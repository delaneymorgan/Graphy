//
//  GraphyView.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyView.h"

#import "GraphyGraph.h"
#import "trace_def.h"
#import "GraphyXAxis.h"
#import "GraphyYAxis.h"
#import "GraphyRange.h"
#import "GraphyXGraduation.h"
#import "GraphyYGraduation.h"


@interface GraphyView (hidden)

-(id)baseInit;

@end


@implementation GraphyView


@synthesize graph = _graph;


#define TRACE_FLAG		(NO)

// ============================================================================================


/**
 * perform basic initialisation for the view
 */
-(id)baseInit {
	TRACE_START();

	// Initialization code
	self.showLegend = NO;
    self.backgroundColor = [UIColor clearColor];
	TRACE_END();
    return self;
	
EXCEPTION:
	return self;
}

// ============================================================================================


/**
 * initialise the view
 *
 * @param qFrame the frame for the view
 * @return id the initialised object
 */
-(id)initWithFrame:(CGRect)qFrame {
	TRACE_START();
    if (self = [super initWithFrame:qFrame]) {
		[self baseInit];
    }
	TRACE_END();
    return self;
}

// ============================================================================================


/**
 * initialise the view
 *
 * @param qDecoder the decoder for the view
 * @return id the initialised object
 */
-(id)initWithCoder:(NSCoder*)qDecoder {
	TRACE_START();
    if ((self = [super initWithCoder:qDecoder])) {
        [self baseInit];        
    }
	TRACE_END();
    return self;
}

// ============================================================================================


/**
 * dealloc the view
 */
-(void)dealloc {
	TRACE_START();
	self.graph = nil;
	TRACE_END();
}

// ============================================================================================


-(GraphyGraph*)graph {
    if (!_graph) {
        _graph = [[GraphyGraph alloc] init];
    }
    return _graph;
}

// ============================================================================================


-(void)setLegend:(GraphyLegend*)qLegend {
	TRACE_START();
	self.graph.legend = qLegend;
	TRACE_END();
}

// ============================================================================================


/**
 * draw the view
 *
 * @param rect the bounding rectangle of the view
 */
-(void)drawRect:(CGRect)rect {
	TRACE_START();
	CGRect workRect = CGRectInset(rect, 50.0, 50.0);
	[self.graph drawRect:workRect showLegend:self.showLegend];
	TRACE_END();
	return;
}

// ============================================================================================


/**
 * set the plots for the graph
 *
 * @param qPlot the plot values
 */
-(void)setPlots:(NSArray*)qPlots {
	TRACE_START();
	
	self.graph.plots = qPlots;
	TRACE_END();
	return;
}

// ============================================================================================


-(void)setXOrigin:(TCoordinate)qOrigin {
	TRACE_START();

	self.graph.xAxis.origin = qOrigin;
	TRACE_END();
	return;
}

// ============================================================================================


-(void)setYOrigin:(TCoordinate)qOrigin {
	TRACE_START();
	
	self.graph.yAxis.origin = qOrigin;
	TRACE_END();
	return;
}

// ============================================================================================


-(void)setXLabel:(GraphyLabel*)qLabel {
	TRACE_START();
	
	self.graph.xAxis.label = qLabel;
	TRACE_END();
	return;
}

// ============================================================================================


-(void)setYLabel:(GraphyLabel*)qLabel {
	TRACE_START();
	
	self.graph.yAxis.label = qLabel;
	TRACE_END();
	return;
}

// ============================================================================================


/**
 * set the range for the x axis
 *
 * @param qMinimum the lowest point of the x axis
 * @param qMaximum the highest point of the x axis
 */
-(void)setXRangeWithMin:(TCoordinate)qMinimum max:(TCoordinate)qMaximum {
	TRACE_START();
	
	self.graph.xAxis.range.minimum = qMinimum;
	self.graph.xAxis.range.maximum = qMaximum;
	TRACE_END();
	return;
}

// ============================================================================================


/**
 * set the range for the y axis
 *
 * @param qMinimum the lowest point of the y axis
 * @param qMaximum the highest point of the y axis
 */
-(void)setYRangeWithMin:(TCoordinate)qMinimum max:(TCoordinate)qMaximum {
	TRACE_START();
	
	self.graph.yAxis.range.minimum = qMinimum;
	self.graph.yAxis.range.maximum = qMaximum;
	TRACE_END();
	return;
}

// ============================================================================================


-(void)setXMajorGraduation:(TCoordinate)qIncrement {
	TRACE_START();
	self.graph.xAxis.majorGraduation.increment = qIncrement;
	TRACE_END();
}

// ============================================================================================


-(void)setYMajorGraduation:(TCoordinate)qIncrement {
	TRACE_START();
	self.graph.yAxis.majorGraduation.increment = qIncrement;
	TRACE_END();
}

// ============================================================================================


-(void)setXMinorGraduation:(TCoordinate)qIncrement {
	TRACE_START();
	self.graph.xAxis.minorGraduation.increment = qIncrement;
	TRACE_END();
}

// ============================================================================================


-(void)setYMinorGraduation:(TCoordinate)qIncrement {
	TRACE_START();
	self.graph.yAxis.minorGraduation.increment = qIncrement;
	TRACE_END();
}

// ============================================================================================


-(NSUInteger)numXMajorGraduations {
	NSUInteger ret = 0;
	TRACE_START();
	ret = (self.graph.xAxis.range.maximum - self.graph.xAxis.range.minimum) / self.graph.xAxis.majorGraduation.increment;
	TRACE_END();
	return ret;
}

// ============================================================================================


-(void)setXMajorGraduationLabels:(NSArray*)qLabels {
	TRACE_START();
	self.graph.xAxis.graduationLabels = qLabels;
	TRACE_END();
}

// ============================================================================================


-(NSUInteger)numYMajorGraduations {
	NSUInteger ret = 0;
	TRACE_START();
	ret = (self.graph.yAxis.range.maximum - self.graph.yAxis.range.minimum) / self.graph.yAxis.majorGraduation.increment;
	TRACE_END();
	return ret;
}

// ============================================================================================


-(void)setYMajorGraduationLabels:(NSArray*)qLabels {
	TRACE_START();
	self.graph.yAxis.graduationLabels = qLabels;
	TRACE_END();
}

@end
