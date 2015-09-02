//
//  GraphyScale.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyScale.h"

#import "trace_def.h"
#import "dbc_def.h"


@implementation GraphyScale

@synthesize numerator;
@synthesize denominator;
@synthesize ratio;


#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)initWithNumerator:(TCoordinate)qNumerator denominator:(TCoordinate)qDenominator {
	TRACE_START();
	
	if ([super init])
	{
		self.numerator = qNumerator;
		self.denominator = qDenominator;
		if (denominator)
		{
			self.ratio = numerator / denominator;
		}
	}
	TRACE_END();
	return self;
}

// ============================================================================================


-(TCoordinate)scale:(TCoordinate)qUnscaledValue {
	TCoordinate ret = 0.0;
	
	TRACE_START();
	
	ret = qUnscaledValue / ratio;
	TRACE_END();
	return ret;
}

// ============================================================================================


-(TCoordinate)descale:(TCoordinate)qScaledValue {
	TCoordinate ret = 0.0;
	
	TRACE_START();
	
	ret = qScaledValue * ratio;
	TRACE_END();
	return ret;
}

// ============================================================================================


-(void)setNumerator:(TCoordinate)qNumerator {
	TRACE_START();
	numerator = qNumerator;
	ratio = 0.0;
	if (denominator)
	{
		ratio = numerator / denominator;
	}
	TRACE_END();
	return;
}

// ============================================================================================


-(void)setDenominator:(TCoordinate)qDenominator {
	TRACE_START();
	denominator = qDenominator;
	ratio = 0.0;
	if (denominator)
	{
		ratio = numerator / denominator;
	}
	TRACE_END();
	return;
}

@end
