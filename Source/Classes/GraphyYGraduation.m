//
//  GraphyGraduation.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyYGraduation.h"

#import "trace_def.h"


@implementation GraphyYGraduation


#define TRACE_FLAG		(YES)

// ============================================================================================


-(instancetype)initWithIncrement:(TCoordinate)qIncrement {
	TRACE_START();
	
	if (self = [super initWithIncrement:qIncrement]) {
    }
	TRACE_END();
	return self;
}

// ============================================================================================


-(void)drawAtPoint:(CGPoint)qPoint {
	CGContextRef context = NULL;
	
	TRACE_START();
	
	// save original context
	context = UIGraphicsGetCurrentContext();
	UIGraphicsPushContext( context);
	
	// draw graduation
	CGPoint point = qPoint;
	// +=+ need to allow for thickness of graduation
	CGContextMoveToPoint( context, point.x - ( self.height / 2), point.y);
	CGContextAddLineToPoint( context, point.x + ( self.height / 2), point.y);
	CGContextSetStrokeColorWithColor( context, self.color.CGColor);
	CGContextSetLineWidth( context, self.width);
	CGContextStrokePath( context);
	
	// restore original context
	UIGraphicsPopContext();
	
	TRACE_END();
	return;
}

@end
