//
//  GraphyPlotPart.m
//  Powerage
//
//  Created by Craig McFarlane on 3/12/10.
//  Copyright 2010 Secure Meters. All rights reserved.
//

#import "GraphyPlotPart.h"

#import "trace_def.h"


@implementation GraphyPlotPart


#define TRACE_FLAG		(NO)

// ============================================================================================


-(instancetype)initWithValue:(TCoordinate)qValue fill:(GraphyFill*)qFill {
	TRACE_START();
	
	if (self = [super init])
	{
		self.value = qValue;
		self.fill = qFill;
	}
	TRACE_END();
	return self;
}

// ============================================================================================


-(void)dealloc {
	TRACE_START();

	self.fill = nil;
	TRACE_END();
}


@end
