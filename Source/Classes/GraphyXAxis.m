//
//  GraphyXAxis.m
//  Powerage
//
//  Created by Craig McFarlane on 30/11/10.
//  Copyright 2010 Secure Meters. All rights reserved.
//

#import "GraphyXAxis.h"

#import "trace_def.h"
#import "dbc_def.h"
#import "Utility.h"
#import "GraphyRange.h"
#import "GraphyScale.h"
#import "GraphyXGraduation.h"
#import "GraphyCoordinate.h"
#import "GraphyLabel.h"


@implementation GraphyXAxis


#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)init {
	TRACE_START();
	
    if (self = [super init]) {
		self.majorGraduation = [[GraphyXGraduation alloc] initWithIncrement:5.0];
		MIDCONDITION( majorGraduation);
		majorGraduation.width = 3.0;
		majorGraduation.color = color;
		self.minorGraduation = [[GraphyXGraduation alloc] initWithIncrement:1.0];
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
	

	// +=+ account for thickness of axis???

	// draw axis line
	CGContextMoveToPoint( context, [coord toCGXCoord:[scale scale:range.minimum]], [coord toCGYCoord:[qOtherScale scale:origin]]);
	CGContextAddLineToPoint( context, [coord toCGXCoord:[scale scale:range.maximum]], [coord toCGYCoord:[qOtherScale scale:origin]]);
	CGContextSetStrokeColorWithColor( context, color.CGColor);
	CGContextSetLineWidth( context, axisWidth);
	CGContextStrokePath( context);
	
	// draw minor graduations
	if (minorGraduation && minorGraduation.increment)
	{
		TCoordinate firstGraduation = trunc( range.minimum / minorGraduation.increment) * minorGraduation.increment;
		TCoordinate thisGraduation = firstGraduation;
		while (thisGraduation <= range.maximum)		// TODO: fix rounding error here
		{
			CGPoint position = CGPointMake( [coord toCGXCoord:[scale scale:thisGraduation]], [coord toCGYCoord:[qOtherScale scale:origin]]);
			TRACE_CHECK( @"Minor graduation position: %@", PrintCGPoint( position));
			[minorGraduation drawAtPoint:position];
			thisGraduation += minorGraduation.increment;
		}
	}
	
	// get graduation label stats
	CGFloat gradLabelHeight = 0.0;
	if (graduationLabels)
	{
		gradLabelHeight = [GraphyGraduation maximumHeight:graduationLabels font:majorGraduation.labelFont];
	}
	
	// draw major graduations & labels
	NSUInteger labelNo = 0;
	if (majorGraduation && majorGraduation.increment)
	{
		TCoordinate firstGraduation = trunc( range.minimum / majorGraduation.increment) * majorGraduation.increment;
		TCoordinate thisGraduation = firstGraduation;
		while (thisGraduation <= range.maximum)		// TODO: fix rounding error here
		{
			CGPoint position = CGPointMake( [coord toCGXCoord:[scale scale:thisGraduation]], [coord toCGYCoord:[qOtherScale scale:origin]]);
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
					labelPos.x -= ([thisLabel sizeWithFont:majorGraduation.labelFont].width / 2);
					labelPos.y += gradLabelHeight + (majorGraduation.height / 2) - majorGraduation.labelFont.ascender;
					[thisLabel drawAtPoint:labelPos withFont:majorGraduation.labelFont]; 
				}
				labelNo++;
			}
			thisGraduation += majorGraduation.increment;
		}
	}
	
	// draw label
	CGFloat labelYPos = rect.origin.y + rect.size.height + [label size].height + gradLabelHeight;
	[label drawForXAtX:[scale scale:((range.maximum - range.minimum)/2)] y:labelYPos coord:coord];
	
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
