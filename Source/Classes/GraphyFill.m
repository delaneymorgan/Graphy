//
//  GraphyFill.m
//  Powerage
//
//  Created by Craig McFarlane on 3/12/10.
//  Copyright 2010 Secure Meters. All rights reserved.
//

#import "GraphyFill.h"

#import "trace_def.h"


@implementation GraphyFill


#define TRACE_FLAG		(NO)

// ============================================================================================


-(instancetype)initWithText:(NSString*)qText startColor:(UIColor*)qStartColor endColor:(UIColor*)qEndColor {
	TRACE_START();
	if (self = [super init])
	{
		self.text = qText;
		self.startColor = qStartColor;
		self.endColor = qEndColor;
	}
	TRACE_END();
	return self;
}

// ============================================================================================


-(void)dealloc {
	TRACE_START();
	self.text = nil;
	self.startColor = nil;
	self.endColor = nil;
	TRACE_END();
}

@end
