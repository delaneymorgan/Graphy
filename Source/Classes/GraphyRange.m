//
//  GraphyRange.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyRange.h"

#import "trace_def.h"
#import "dbc_def.h"


@implementation GraphyRange

@synthesize minimum;
@synthesize maximum;


#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)initWithMinimum:(TCoordinate)qMinimum maximum:(TCoordinate)qMaximum {
	TRACE_START();
	
	if ([super init])
	{
		self.minimum = qMinimum;
		self.maximum = qMaximum;
	}
	TRACE_END();
	return self;
}

@end
