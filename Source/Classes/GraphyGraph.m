//
//  GraphyGraph.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyGraph.h"

#import "GraphyXAxis.h"
#import "GraphyYAxis.h"
#import "trace_def.h"
#import "GraphyScale.h"
#import "GraphyRange.h"
#import "GraphyPlot.h"
#import "GraphyPlotPart.h"
#import "GraphyFill.h"
#import "GraphyCoordinate.h"
#import "GraphyGraduation.h"
#import "GraphyLabel.h"
#import "GraphyLegend.h"


@implementation GraphyGraph


@synthesize xAxis = _xAxis;
@synthesize yAxis = _yAxis;
@synthesize legend = _legend;


#define TRACE_FLAG		(NO)

// ============================================================================================


-(instancetype)init {
	TRACE_START();

    if (self = [super init])
	{
    }
	TRACE_END();
	return self;
}

// ============================================================================================


-(void)dealloc {
	self.xAxis = nil;
	self.yAxis = nil;
	self.legend = nil;
}

// ============================================================================================


-(GraphyXAxis*)xAxis {
    if (!_xAxis) {
        _xAxis = [[GraphyXAxis alloc] init];
    }
    return _xAxis;
}

// ============================================================================================


-(GraphyYAxis*)yAxis {
    if (!_yAxis) {
        _yAxis = [[GraphyYAxis alloc] init];
    }
    return _yAxis;
}

// ============================================================================================


-(GraphyLegend*)legend {
    if (!_legend) {
        _legend = [[GraphyLegend alloc] init];
    }
    return _legend;
}

// ============================================================================================


/**
 * draw the plot
 *
 * @param qContext the graphic context
 * @param qRect the bounding rectangle of the view
 */
-(void)drawPlot:(CGContextRef)qContext rect:(CGRect)qRect {
	GraphyCoordinate* coord = nil;

	TRACE_START();

	GraphyScale* xScale = self.xAxis.scale;
	GraphyScale* yScale = self.yAxis.scale;
	
	// get a coordinate converter
	coord = [[GraphyCoordinate alloc] initWithFrame:qRect];
	
	NSEnumerator* plotEnum = [self.plots objectEnumerator];
	GraphyPlot* thisPlot = nil;
	while (thisPlot = [plotEnum nextObject])
	{
		TCoordinate baseY = 0.0;				// the base always starts at 0.0
		TCoordinate baseX = thisPlot.baseCoord;
		NSEnumerator* partEnum = [thisPlot.parts objectEnumerator];
		GraphyPlotPart* thisPart = nil;
		while (thisPart = [partEnum nextObject])
		{
			// TODO: take into account width of bar
			CGRect partRect;
			TRACE_CHECK( @"thisPart.fill.text: %@", thisPart.fill.text);
			TRACE_CHECK( @"baseX: %f", baseX);
			TRACE_CHECK( @"baseY: %f", baseY);
			TRACE_CHECK( @"[xScale scale:baseX]: %f", [xScale scale:baseX]);
			TRACE_CHECK( @"[yScale scale:baseY]: %f", [yScale scale:baseY]);
			TRACE_CHECK( @"[coord toCGXCoord:[xScale scale:baseX]]: %f", [coord toCGXCoord:[xScale scale:baseX]]);
			TRACE_CHECK( @"[coord toCGYCoord:[yScale scale:baseY]]: %f", [coord toCGYCoord:[yScale scale:baseY]]);
			partRect.origin.x = [coord toCGXCoord:[xScale scale:baseX]] - (thisPlot.width/2);
			partRect.origin.y = [coord toCGYCoord:[yScale scale:(baseY + thisPart.value)]];
			partRect.size.width = thisPlot.width;
			partRect.size.height = [yScale scale:thisPart.value];
			CGContextAddRect( qContext, partRect);
			CGContextSetFillColorWithColor( qContext, thisPart.fill.startColor.CGColor);
			CGContextSetStrokeColorWithColor( qContext, thisPart.fill.startColor.CGColor);
			CGContextFillPath( qContext);
			baseY += thisPart.value;
		}

		// print label if present
		if (thisPlot.label)
		{
			[thisPlot.label drawAtX:[xScale scale:baseX] y:[yScale scale:0.0] coord:coord];
		}
		
	}
	
	TRACE_END();
	return;
}

// ============================================================================================


/**
 * draw the view
 *
 * @param qRect the bounding rectangle of the view
 * @param qShowLegend YES => show legend, NO => don't
 */
-(void)drawSkeleton:(CGRect)qRect showLegend:(BOOL)qShowLegend {
	CGContextRef context = NULL;
	
	TRACE_START();
	
	context = UIGraphicsGetCurrentContext();
    
    TRACE_CHECK( @"qRect: (%f:%f):(%f:%f)", qRect.origin.x, qRect.origin.y, qRect.size.width, qRect.size.height);
	
	// get scales for plot
	GraphyScale* xScale = self.xAxis.scale;
	GraphyScale* yScale = self.yAxis.scale;
	
	// set scale denomitators
	TCoordinate xAdjust = 0.0;
	if (self.xAxis.origin < self.xAxis.range.minimum)
	{
		xAdjust = (self.xAxis.range.minimum - self.xAxis.origin);
	}
	else if (self.xAxis.origin > self.xAxis.range.maximum)
	{
		xAdjust = (self.xAxis.origin - self.xAxis.range.minimum);
	}
    TRACE_CHECK( @"xAdjust: %f", xAdjust);
	TCoordinate yAdjust = 0.0;
	if (self.yAxis.origin < self.yAxis.range.minimum)
	{
		yAdjust = (self.yAxis.range.minimum - self.yAxis.origin);
	}
	else if (self.yAxis.origin > self.yAxis.range.maximum)
	{
		yAdjust = (self.yAxis.origin - self.yAxis.range.minimum);
	}
    TRACE_CHECK( @"yAdjust: %f", yAdjust);
	
	xScale.numerator = (self.xAxis.range.maximum - self.xAxis.range.minimum) + xAdjust;
	yScale.numerator = (self.yAxis.range.maximum - self.yAxis.range.minimum) + yAdjust;
	xScale.denominator = qRect.size.width;
	yScale.denominator = qRect.size.height;
    TRACE_CHECK( @"xScale: %f/%f", xScale.numerator, xScale.denominator);
    TRACE_CHECK( @"yScale: %f/%f", yScale.numerator, yScale.denominator);

	[self drawPlot:context rect:qRect];

	[self.xAxis drawRect:qRect otherScale:yScale];
	[self.yAxis drawRect:qRect otherScale:xScale];

	TRACE_END();
	return;
}

// ============================================================================================


/**
 * draw the view
 *
 * @param qRect the bounding rectangle of the view
 * @param qShowLegend YES => show legend, NO => don't
 */
-(void)drawElements:(CGRect)qRect showLegend:(BOOL)qShowLegend {
	TRACE_START();
	
	CGRect skeletonRect = qRect;		// start with original rect

    TRACE_CHECK( @"qRect: (%f:%f):(%f:%f)", qRect.origin.x, qRect.origin.y, qRect.size.width, qRect.size.height);

    // subtract width of yAxis label
	CGSize yAxisLabelSize = [self.yAxis.label size];
	skeletonRect.origin.x += yAxisLabelSize.width;
	skeletonRect.size.width -= yAxisLabelSize.width;
	
	// subtract height of xAxis label
	CGSize xAxisLabelSize = [self.xAxis.label size];
	skeletonRect.size.height -= xAxisLabelSize.height;

	// subtract width of yGraduationLabels
	if (self.yAxis.graduationLabels)
	{
		CGFloat yGraduationLabelsWidth = [GraphyGraduation maximumWidth:self.yAxis.graduationLabels font:self.yAxis.majorGraduation.labelFont];
		skeletonRect.origin.x += yGraduationLabelsWidth;
		skeletonRect.size.width -= yGraduationLabelsWidth;
	}

	// subtract height of xGraduationLabels
	if (self.xAxis.graduationLabels)
	{
		CGFloat xGraduationLabelsHeight = [GraphyGraduation maximumHeight:self.xAxis.graduationLabels font:self.yAxis.majorGraduation.labelFont];
		skeletonRect.size.height -= xGraduationLabelsHeight;
	}
	
	[self drawSkeleton:skeletonRect showLegend:(BOOL)qShowLegend];
	
	TRACE_END();
	return;
}

// ============================================================================================


/**
 * draw the view
 *
 * @param qRect the bounding rectangle of the view
 * @param qShowLegend YES => show legend, NO => don't
 */
-(void)drawRect:(CGRect)qRect showLegend:(BOOL)qShowLegend {
	TRACE_START();

	if (qShowLegend && self.legend)
	{
		[self.legend drawRect:qRect];
	} else
	{
		[self drawElements:qRect showLegend:(BOOL)qShowLegend];
	}
	
	TRACE_END();
	return;
}

@end
