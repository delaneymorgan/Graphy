//
//  GraphyScale.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyScale.h"

#import "trace_def.h"


@implementation GraphyScale


#define TRACE_FLAG		(NO)

// ============================================================================================


-(instancetype)initWithNumerator:(TCoordinate)qNumerator denominator:(TCoordinate)qDenominator {
	TRACE_START();
	
	if (self = [super init])
	{
		self.numerator = qNumerator;
		self.denominator = qDenominator;
		if (self.denominator)
		{
			self.ratio = self.numerator / self.denominator;
		}
	}
	TRACE_END();
	return self;
}

// ============================================================================================


-(TCoordinate)scale:(TCoordinate)qUnscaledValue {
	TCoordinate ret = 0.0;
	
	TRACE_START();
	
	ret = qUnscaledValue / self.ratio;
	TRACE_END();
	return ret;
}

// ============================================================================================


-(TCoordinate)descale:(TCoordinate)qScaledValue {
	TCoordinate ret = 0.0;
	
	TRACE_START();
	
	ret = qScaledValue * self.ratio;
	TRACE_END();
	return ret;
}

// ============================================================================================


-(void)setNumerator:(TCoordinate)qNumerator {
	TRACE_START();
	_numerator = qNumerator;
	self.ratio = 0.0;
	if (self.denominator)
	{
		self.ratio = _numerator / self.denominator;
	}
	TRACE_END();
	return;
}

// ============================================================================================


-(void)setDenominator:(TCoordinate)qDenominator {
	TRACE_START();
	_denominator = qDenominator;
	self.ratio = 0.0;
	if (_denominator)
	{
		self.ratio = self.numerator / _denominator;
	}
	TRACE_END();
	return;
}

@end
