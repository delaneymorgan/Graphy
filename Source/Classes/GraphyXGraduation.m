//
//  GraphyGraduation.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyXGraduation.h"

#import "trace_def.h"


@implementation GraphyXGraduation


#define TRACE_FLAG		(NO)

// ============================================================================================


-(instancetype)initWithIncrement:(TCoordinate)qIncrement {
	TRACE_START();
	
	if (self = [super initWithIncrement:qIncrement]) {
    }
	TRACE_END();
	return self;
	
EXCEPTION:
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
	CGContextMoveToPoint( context, point.x, point.y - ( self.height / 2));
	CGContextAddLineToPoint( context, point.x, point.y + ( self.height / 2));
	CGContextSetStrokeColorWithColor( context, self.color.CGColor);
	CGContextSetLineWidth( context, self.width);
	CGContextStrokePath( context);
	
	// restore original context
	UIGraphicsPopContext();
	
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

@end
