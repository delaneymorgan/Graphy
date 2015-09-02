//
//  GraphyXAxis.m
//  Powerage
//
//  Created by Craig McFarlane on 30/11/10.
//  Copyright 2010 Secure Meters. All rights reserved.
//

#import "GraphyYAxis.h"

#import "trace_def.h"
#import "dbc_def.h"
#import "Utility.h"
#import "GraphyRange.h"
#import "GraphyScale.h"
#import "GraphyYGraduation.h"
#import "GraphyCoordinate.h"
#import "GraphyLabel.h"


@implementation GraphyYAxis


#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)init {
	TRACE_START();
	
    if (self = [super init]) {
		self.majorGraduation = [[GraphyYGraduation alloc] initWithIncrement:5.0];
		MIDCONDITION( majorGraduation);
		majorGraduation.width = 3.0;
		majorGraduation.color = color;
		self.minorGraduation = [[GraphyYGraduation alloc] initWithIncrement:1.0];
		MIDCONDITION( minorGraduation);
		minorGraduation.color = color;
    }
	TRACE_END();
	return self;
	
EXCEPTION:
	return self;
}

// ============================================================================================


/**
 * draw the view
 *
 * @param rect the bounding rectangle of the view
 * @param qOtherScale the scale for the other axis (used to place origin)
 */
-(void)drawRect:(CGRect)rect otherScale:(GraphyScale*)qOtherScale {
	CGContextRef context = NULL;
	GraphyCoordinate* coord = nil;
	
	TRACE_START();
	
	PRECONDITION( qOtherScale);

	[super drawRect:rect otherScale:qOtherScale];
	
	// get a coordinate converter
	coord = [[GraphyCoordinate alloc] initWithFrame:rect];
	MIDCONDITION( coord);
	
	// save original context
	context = UIGraphicsGetCurrentContext();
	MIDCONDITION( context);
	UIGraphicsPushContext( context);
	
	TRACE_CHECK( @"rect: %@", PrintCGRect( rect));
	
	// +=+ account for thickness of axis???
	
	// draw axis line
	CGContextMoveToPoint( context, [coord toCGXCoord:[qOtherScale scale:origin]], [coord toCGYCoord:[scale scale:range.minimum]]);
	CGContextAddLineToPoint( context, [coord toCGXCoord:[qOtherScale scale:origin]], [coord toCGYCoord:[scale scale:range.maximum]]);
	CGContextSetStrokeColorWithColor( context, color.CGColor);
	CGContextSetLineWidth( context, axisWidth);
	CGContextStrokePath( context);
	
	// draw minor graduations
	if (minorGraduation && minorGraduation.increment)
	{
		TCoordinate firstGraduation = trunc( range.minimum / minorGraduation.increment) * minorGraduation.increment;
		TCoordinate thisGraduation = firstGraduation;
		while (thisGraduation <= range.maximum)
		{
			CGPoint position = CGPointMake( [coord toCGXCoord:[qOtherScale scale:origin]], [coord toCGYCoord:[scale scale:thisGraduation]]);
			TRACE_CHECK( @"Minor graduation position: %@", PrintCGPoint( position));
			[minorGraduation drawAtPoint:position];
			thisGraduation += minorGraduation.increment;
		}
	}
	
	// draw graduation labels
	CGFloat gradLabelWidth = 0.0;
	if (graduationLabels)
	{
		gradLabelWidth = [GraphyGraduation maximumWidth:graduationLabels font:majorGraduation.labelFont];
	}
	
	// draw major graduations & labels
	NSUInteger labelNo = 0;
	if (majorGraduation && majorGraduation.increment)
	{
		TCoordinate firstGraduation = trunc( range.minimum / majorGraduation.increment) * majorGraduation.increment;
		TCoordinate thisGraduation = firstGraduation;
		while (thisGraduation <= range.maximum)
		{
			CGPoint position = CGPointMake( [coord toCGXCoord:[qOtherScale scale:origin]], [coord toCGYCoord:[scale scale:thisGraduation]]);
			TRACE_CHECK( @"Major graduation position: %@", PrintCGPoint( position));
			[majorGraduation drawAtPoint:position];
			CGContextSetFillColorWithColor( context, majorGraduation.labelColor.CGColor);
			TRACE_CHECK( @"position: %@", PrintCGPoint( position));
			if (thisGraduation >= range.minimum)
			{
				if (labelNo < [graduationLabels count])
				{
					NSString* thisLabel = [graduationLabels objectAtIndex:labelNo];
					CGPoint labelPos = position;
					CGFloat rightJust = gradLabelWidth - [thisLabel sizeWithFont:majorGraduation.labelFont].width;
					labelPos.x -= gradLabelWidth + (majorGraduation.height / 2);
					labelPos.x += rightJust;
					labelPos.y -= majorGraduation.labelFont.lineHeight / 2;
					[thisLabel drawAtPoint:labelPos withFont:majorGraduation.labelFont]; 
				}
				labelNo++;
			}
			thisGraduation += majorGraduation.increment;
		}
	}
	
	// draw label
	CGFloat labelXPos = rect.origin.x - [label size].width - gradLabelWidth;
	[label drawForYAtX:labelXPos y:[scale scale:((range.maximum - range.minimum)/2)] coord:coord];

	// restore original context
	UIGraphicsPopContext();
	
	[coord release];
	
END:
	TRACE_END();
	return;
	
EXCEPTION:
	RELEASEIF( coord);
	return;
}

@end
