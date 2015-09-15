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


@interface GraphyAxis (hidden)

-(id)baseInit;

@end


@implementation GraphyAxis


@synthesize labeller = _labeller;
@synthesize range = _range;
@synthesize scale = _scale;


#define TRACE_FLAG		(NO)

// ============================================================================================


/**
 * perform basic initialisation for the view
 */
-(id)baseInit {
	TRACE_START();
	
	// Initialization code
	self.origin = 0.0;
	self.color = [UIColor whiteColor];
	self.axisWidth = 1.0;
	TRACE_END();
    return self;
}

// ============================================================================================


-(instancetype)init {
	TRACE_START();
	
    if (self = [super init]) {
		[self baseInit];
    }
	TRACE_END();
	return self;
}

// ============================================================================================


-(GraphyLabel*)labeller {
    if (!_labeller) {
        _labeller = [[GraphyLabel alloc] init];
    }
    return _labeller;
}
// ============================================================================================


-(GraphyRange*)range {
    if (!_range) {
        _range = [[GraphyRange alloc] initWithMinimum:0.0 maximum:10.0];
    }
    return _range;
}
// ============================================================================================


-(GraphyScale*)scale {
    if (!_scale) {
        _scale = [[GraphyScale alloc] initWithNumerator:1.0 denominator:1.0];
    }
    return _scale;
}
// ============================================================================================


-(instancetype)initWithOrigin:(TCoordinate)qOrigin {
	TRACE_START();
	
    if (self = [super init]) {
		[self baseInit];
		self.origin = qOrigin;
    }
	TRACE_END();
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
}

@end
