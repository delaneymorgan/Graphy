//
//  GraphyPlotPart.m
//  Powerage
//
//  Created by Craig McFarlane on 3/12/10.
//  Copyright 2010 Secure Meters. All rights reserved.
//

#import "GraphyPlotPart.h"

#import "dbc_def.h"
#import "trace_def.h"


@implementation GraphyPlotPart

@synthesize fill;
@synthesize value;


#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)initWithValue:(TCoordinate)qValue fill:(GraphyFill*)qFill {
	TRACE_START();
	
	if ([super init])
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
	[super dealloc];
	TRACE_END();
}


@end
