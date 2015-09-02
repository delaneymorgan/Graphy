//
//  GraphyPlot.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyPlot.h"

#import "trace_def.h"
#import "dbc_def.h"
#import "GraphyLabel.h"


@implementation GraphyPlot

@synthesize baseCoord;
@synthesize label;
@synthesize parts;
@synthesize width;

#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)initWithBaseCoord:(TCoordinate)qBaseCoord width:(CGFloat)qWidth label:(GraphyLabel*)qLabel parts:(NSArray*)qParts {
	TRACE_START();
	
	if ([super init])
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
	[super dealloc];
	TRACE_END();
}

@end
