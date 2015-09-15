//
//  GraphyXAxis.m
//  Powerage
//
//  Created by Craig McFarlane on 30/11/10.
//  Copyright 2010 Secure Meters. All rights reserved.
//

#import "GraphyYAxis.h"

#import "trace_def.h"
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
		self.majorGraduation.width = 3.0;
		self.majorGraduation.color = self.color;
		self.minorGraduation = [[GraphyYGraduation alloc] initWithIncrement:1.0];
		self.minorGraduation.color = self.color;
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
	
	[super drawRect:rect otherScale:qOtherScale];
	
	// get a coordinate converter
	coord = [[GraphyCoordinate alloc] initWithFrame:rect];
	
	// save original context
	context = UIGraphicsGetCurrentContext();
	UIGraphicsPushContext( context);
	
	// +=+ account for thickness of axis???
	
	// draw axis line
	CGContextMoveToPoint( context, [coord toCGXCoord:[qOtherScale scale:self.origin]], [coord toCGYCoord:[self.scale scale:self.range.minimum]]);
	CGContextAddLineToPoint( context, [coord toCGXCoord:[qOtherScale scale:self.origin]], [coord toCGYCoord:[self.scale scale:self.range.maximum]]);
	CGContextSetStrokeColorWithColor( context, self.color.CGColor);
	CGContextSetLineWidth( context, self.axisWidth);
	CGContextStrokePath( context);
	
	// draw minor graduations
	if (self.minorGraduation && self.minorGraduation.increment)
	{
		TCoordinate firstGraduation = trunc( self.range.minimum / self.minorGraduation.increment) * self.minorGraduation.increment;
		TCoordinate thisGraduation = firstGraduation;
		while (thisGraduation <= self.range.maximum)
		{
			CGPoint position = CGPointMake( [coord toCGXCoord:[qOtherScale scale:self.origin]], [coord toCGYCoord:[self.scale scale:thisGraduation]]);
			[self.minorGraduation drawAtPoint:position];
            TRACE_CHECK( @"self.minorGraduation: %@", self.minorGraduation);
			thisGraduation += self.minorGraduation.increment;
		}
	}
	
	// draw graduation labels
	CGFloat gradLabelWidth = 0.0;
	if (self.graduationLabels)
	{
		gradLabelWidth = [GraphyGraduation maximumWidth:self.graduationLabels font:self.majorGraduation.labelFont];
	}
	
	// draw major graduations & labels
	NSUInteger labelNo = 0;
	if (self.majorGraduation && self.majorGraduation.increment)
	{
		TCoordinate firstGraduation = trunc( self.range.minimum / self.majorGraduation.increment) * self.majorGraduation.increment;
		TCoordinate thisGraduation = firstGraduation;
		while (thisGraduation <= self.range.maximum)
		{
			CGPoint position = CGPointMake( [coord toCGXCoord:[qOtherScale scale:self.origin]], [coord toCGYCoord:[self.scale scale:thisGraduation]]);
			[self.majorGraduation drawAtPoint:position];
            TRACE_CHECK( @"self.majorGraduation: %@", self.majorGraduation);
			CGContextSetFillColorWithColor( context, self.majorGraduation.labelColor.CGColor);
			if (thisGraduation >= self.range.minimum)
			{
				if (labelNo < [self.graduationLabels count])
				{
					NSString* thisLabel = [self.graduationLabels objectAtIndex:labelNo];
					CGPoint labelPos = position;
                    NSDictionary* attributes = @{ NSForegroundColorAttributeName:self.majorGraduation.labelColor, NSFontAttributeName:self.majorGraduation.labelFont};
					CGFloat rightJust = gradLabelWidth - [thisLabel sizeWithAttributes:attributes].width;
					labelPos.x -= gradLabelWidth + (self.majorGraduation.height / 2);
					labelPos.x += rightJust;
					labelPos.y -= self.majorGraduation.labelFont.lineHeight / 2;
                    [thisLabel drawAtPoint:labelPos withAttributes:attributes];
                    TRACE_CHECK( @"thisLabel: %@", thisLabel);
				}
				labelNo++;
			}
			thisGraduation += self.majorGraduation.increment;
		}
	}
	
	// draw label
	CGFloat labelXPos = rect.origin.x - [self.label size].width - gradLabelWidth;
	[self.label drawForYAtX:labelXPos y:[self.scale scale:((self.range.maximum - self.range.minimum)/2)] coord:coord];

	// restore original context
	UIGraphicsPopContext();
	
	TRACE_END();
	return;
}

@end
