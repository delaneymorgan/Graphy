//
//  GraphyXAxis.m
//  Powerage
//
//  Created by Craig McFarlane on 30/11/10.
//  Copyright 2010 Secure Meters. All rights reserved.
//

#import "GraphyXAxis.h"

#import "trace_def.h"
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
		self.majorGraduation.width = 3.0;
		self.majorGraduation.color = self.color;
		self.minorGraduation = [[GraphyXGraduation alloc] initWithIncrement:1.0];
		self.minorGraduation.color = self.color;
    }
	TRACE_END();
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
    TRACE_CHECK( @"Draw Axis Line 1: (%f,%f)", [coord toCGXCoord:[self.scale scale:self.range.minimum]], [coord toCGYCoord:[qOtherScale scale:self.origin]]);
	CGContextMoveToPoint( context, [coord toCGXCoord:[self.scale scale:self.range.minimum]], [coord toCGYCoord:[qOtherScale scale:self.origin]]);
    TRACE_CHECK( @"Draw Axis Line 2: (%f,%f)", [coord toCGXCoord:[self.scale scale:self.range.maximum]], [coord toCGYCoord:[qOtherScale scale:self.origin]]);
	CGContextAddLineToPoint( context, [coord toCGXCoord:[self.scale scale:self.range.maximum]], [coord toCGYCoord:[qOtherScale scale:self.origin]]);
	CGContextSetStrokeColorWithColor( context, self.color.CGColor);
	CGContextSetLineWidth( context, self.axisWidth);
	CGContextStrokePath( context);
	
	// draw minor graduations
	if (self.minorGraduation && self.minorGraduation.increment)
	{
		TCoordinate firstGraduation = trunc( self.range.minimum / self.minorGraduation.increment) * self.minorGraduation.increment;
		TCoordinate thisGraduation = firstGraduation;
		while (thisGraduation <= self.range.maximum)		// TODO: fix rounding error here
		{
			CGPoint position = CGPointMake( [coord toCGXCoord:[self.scale scale:thisGraduation]], [coord toCGYCoord:[qOtherScale scale:self.origin]]);
			[self.minorGraduation drawAtPoint:position];
            TRACE_CHECK( @"self.minorGraduation: %@", self.minorGraduation);
			thisGraduation += self.minorGraduation.increment;
		}
	}
	
	// get graduation label stats
	CGFloat gradLabelHeight = 0.0;
	if (self.graduationLabels)
	{
		gradLabelHeight = [GraphyGraduation maximumHeight:self.graduationLabels font:self.majorGraduation.labelFont];
	}
	
	// draw major graduations & labels
	NSUInteger labelNo = 0;
	if (self.majorGraduation && self.majorGraduation.increment)
	{
		TCoordinate firstGraduation = trunc( self.range.minimum / self.majorGraduation.increment) * self.majorGraduation.increment;
		TCoordinate thisGraduation = firstGraduation;
		while (thisGraduation <= self.range.maximum)		// TODO: fix rounding error here
		{
			CGPoint position = CGPointMake( [coord toCGXCoord:[self.scale scale:thisGraduation]], [coord toCGYCoord:[qOtherScale scale:self.origin]]);
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
                    labelPos.x -= ([thisLabel sizeWithAttributes:attributes].width / 2);
					labelPos.y += gradLabelHeight + (self.majorGraduation.height / 2) - self.majorGraduation.labelFont.ascender;
                    [thisLabel drawAtPoint:labelPos withAttributes:attributes];
                    TRACE_CHECK( @"%@: %f:%f", thisLabel, labelPos.x, labelPos.y);
				}
				labelNo++;
			}
			thisGraduation += self.majorGraduation.increment;
		}
	}
	
	// draw label
	CGFloat labelYPos = rect.origin.y + rect.size.height + [self.label size].height + gradLabelHeight;
	[self.label drawForXAtX:[self.scale scale:((self.range.maximum - self.range.minimum)/2)] y:labelYPos coord:coord];
	
	// restore original context
	UIGraphicsPopContext();

    TRACE_END();
	return;
}

@end
