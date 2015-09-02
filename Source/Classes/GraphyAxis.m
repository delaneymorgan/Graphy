//
//  GraphyAxis.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyAxis.h"

#import "GraphyLabel.h"
#import "GraphyRange.h"
#import "GraphyGraduation.h"
#import "GraphyScale.h"
#import "trace_def.h"
#import "dbc_def.h"
//#import "Utility.h"


@interface GraphyAxis (hidden)

-(id)baseInit;

@end


@implementation GraphyAxis

@synthesize label;
@synthesize origin;
@synthesize labeller;
@synthesize range;
@synthesize scale;
@synthesize majorGraduation;
@synthesize minorGraduation;
@synthesize color;
@synthesize axisWidth;
@synthesize graduationLabels;


#define TRACE_FLAG		(NO)

// ============================================================================================


/**
 * perform basic initialisation for the view
 */
-(id)baseInit {
	TRACE_START();
	
	// Initialization code
	self.origin = 0.0;
	self.labeller = [[GraphyLabel alloc] init];
	MIDCONDITION( labeller);
	self.range = [[GraphyRange alloc] initWithMinimum:0.0 maximum:10.0];
	MIDCONDITION( range);
	self.scale = [[GraphyScale alloc] initWithNumerator:1.0 denominator:1.0];
	MIDCONDITION( scale);
	self.color = [UIColor whiteColor];
	self.axisWidth = 1.0;
	TRACE_END();
    return self;
	
EXCEPTION:
	return self;
}

// ============================================================================================


-(id)init {
	TRACE_START();
	
    if (self = [super init]) {
		[self baseInit];
    }
	TRACE_END();
	return self;
	
EXCEPTION:
	return self;
}

// ============================================================================================


-(id)initWithOrigin:(TCoordinate)qOrigin {
	TRACE_START();
	
    if (self = [super init]) {
		[self baseInit];
		self.origin = qOrigin;
    }
	TRACE_END();
	return self;
	
EXCEPTION:
	return self;
}

// ============================================================================================


-(void)dealloc {
	self.label = nil;
	self.labeller = nil;
	self.range = nil;
	self.scale = nil;
	self.color = nil;
	self.graduationLabels = nil;
	[super dealloc];
}

// ============================================================================================


/**
 * draw the view
 *
 * @param rect the bounding rectangle of the view
 */
-(void)drawRect:(CGRect)rect otherScale:(GraphyScale*)qOtherScale {
	TRACE_START();
	
END:
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

@end
