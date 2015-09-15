//
//  GraphyRange.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyRange.h"

#import "trace_def.h"


@implementation GraphyRange


#define TRACE_FLAG		(NO)

// ============================================================================================


-(instancetype)initWithMinimum:(TCoordinate)qMinimum maximum:(TCoordinate)qMaximum {
	TRACE_START();
	
	if (self = [super init])
	{
		self.minimum = qMinimum;
		self.maximum = qMaximum;
	}
	TRACE_END();
	return self;
}

@end
