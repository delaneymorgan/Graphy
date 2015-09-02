//
//  GraphyCoordinate.m
//  Powerage
//
//  Created by Craig McFarlane on 1/12/10.
//  Copyright 2010 Secure Meters. All rights reserved.
//

#import "GraphyCoordinate.h"

#import "trace_def.h"


@implementation GraphyCoordinate

@synthesize frame;


#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)initWithFrame:(CGRect)qFrame {
	TRACE_START();
	if ([super init])
	{
		frame = qFrame;
	}
	TRACE_END();
	return self;
}

// ============================================================================================


-(CGFloat)toCGXCoord:(TCoordinate)qGraphCoord {
	CGFloat ret = 0.0;
	
	TRACE_START();
	ret = [GraphyCoordinate toCGXCoord:qGraphCoord frame:frame];
	TRACE_END();
	return ret;
}

// ============================================================================================


-(CGFloat)toCGYCoord:(TCoordinate)qGraphCoord {
	CGFloat ret = 0.0;
	
	TRACE_START();
	ret = [GraphyCoordinate toCGYCoord:qGraphCoord frame:frame];
	TRACE_END();
	return ret;
}

// ============================================================================================


+(CGFloat)toCGXCoord:(TCoordinate)qGraphCoord frame:(CGRect)qFrame {
	CGFloat ret = 0.0;
	
	TRACE_START();
	
	ret = qGraphCoord + qFrame.origin.x;
	TRACE_END();
	return ret;
}

// ============================================================================================


+(CGFloat)toCGYCoord:(TCoordinate)qGraphCoord frame:(CGRect)qFrame {
	CGFloat ret = 0.0;
	
	TRACE_START();
	
	ret = qFrame.size.height - qGraphCoord + qFrame.origin.y;
	TRACE_END();
	return ret;
}

@end
