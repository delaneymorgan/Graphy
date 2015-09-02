//
//  GraphyGraduation.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyYGraduation.h"

#import "dbc_def.h"
#import "trace_def.h"
#import "Utility.h"


@implementation GraphyYGraduation


#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)initWithIncrement:(TCoordinate)qIncrement {
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
	MIDCONDITION( context);
	UIGraphicsPushContext( context);
	
	TRACE_CHECK( @"qPoint: %@", PrintCGPoint( qPoint));
	
	// draw graduation
	CGPoint point = qPoint;
	// +=+ need to allow for thickness of graduation
	CGContextMoveToPoint( context, point.x - ( height / 2), point.y);
	CGContextAddLineToPoint( context, point.x + ( height / 2), point.y);
	CGContextSetStrokeColorWithColor( context, color.CGColor);
	CGContextSetLineWidth( context, width);
	CGContextStrokePath( context);
	
	// restore original context
	UIGraphicsPopContext();
	
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

@end
