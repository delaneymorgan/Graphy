//
//  GraphyPlot.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyPlot.h"

#import "trace_def.h"
#import "GraphyLabel.h"


@implementation GraphyPlot


#define TRACE_FLAG		(NO)

// ============================================================================================


-(instancetype)initWithBaseCoord:(TCoordinate)qBaseCoord width:(CGFloat)qWidth label:(GraphyLabel*)qLabel parts:(NSArray*)qParts {
	TRACE_START();
	
	if (self = [super init])
	{
		self.baseCoord = qBaseCoord;
		self.label = qLabel;
		self.parts = qParts;
		self.width = qWidth;
	}
	
	TRACE_END();
	return self;
}

// ============================================================================================


-(void)dealloc {
	TRACE_START();
	self.label = nil;
	self.parts = nil;
	TRACE_END();
}

@end
