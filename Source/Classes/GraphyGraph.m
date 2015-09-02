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
#import "dbc_def.h"
#import "trace_def.h"
#import "GraphyScale.h"
#import "GraphyRange.h"
#import "GraphyPlot.h"
#import "GraphyPlotPart.h"
#import "GraphyFill.h"
#import "GraphyCoordinate.h"
#import "GraphyGraduation.h"
//#import "UIColor-Expanded.h"
#import "GraphyLabel.h"
#import "GraphyLegend.h"


@implementation GraphyGraph

@synthesize xAxis;
@synthesize yAxis;
@synthesize plots;
@synthesize legend;


#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)init {
	TRACE_START();

    if (self = [super init])
	{
		self.xAxis = [[GraphyXAxis alloc] init];
		MIDCONDITION( xAxis);
		self.yAxis = [[GraphyYAxis alloc] init];
		MIDCONDITION( yAxis);
		self.legend = [[GraphyLegend alloc] init];
		MIDCONDITION( legend);
    }
	TRACE_END();
	return self;
	
EXCEPTION:
	return self;
}

// ============================================================================================


-(void)dealloc {
	self.xAxis = nil;
	self.yAxis = nil;
	self.legend = nil;
	[super dealloc];
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

	PRECONDITION( qContext);
	
	GraphyScale* xScale = xAxis.scale;
	MIDCONDITION( xScale);
	GraphyScale* yScale = yAxis.scale;
	MIDCONDITION( yScale);
	
	// get a coordinate converter
	coord = [[GraphyCoordinate alloc] initWithFrame:qRect];
	MIDCONDITION( coord);
	
	NSEnumerator* plotEnum = [plots objectEnumerator];
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
	
	[coord release];
	TRACE_END();
	return;
	
EXCEPTION:
	RELEASEIF( coord);
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
	MIDCONDITION( context);
	
	// get scales for plot
	GraphyScale* xScale = xAxis.scale;
	MIDCONDITION( xScale);
	GraphyScale* yScale = yAxis.scale;
	MIDCONDITION( yScale);
	
	// set scale denomitators
	TCoordinate xAdjust = 0.0;
	if (xAxis.origin < xAxis.range.minimum)
	{
		xAdjust = (xAxis.range.minimum - xAxis.origin);
	}
	else if (xAxis.origin > xAxis.range.maximum)
	{
		xAdjust = (xAxis.origin - xAxis.range.minimum);
	}
	TCoordinate yAdjust = 0.0;
	if (yAxis.origin < yAxis.range.minimum)
	{
		yAdjust = (yAxis.range.minimum - yAxis.origin);
	}
	else if (yAxis.origin > yAxis.range.maximum)
	{
		yAdjust = (yAxis.origin - yAxis.range.minimum);
	}
	
	xScale.numerator = (xAxis.range.maximum - xAxis.range.minimum) + xAdjust;
	yScale.numerator = (yAxis.range.maximum - yAxis.range.minimum) + yAdjust;
	xScale.denominator = qRect.size.width;
	yScale.denominator = qRect.size.height;

	[self drawPlot:context rect:qRect];

	[xAxis drawRect:qRect otherScale:yScale];
	[yAxis drawRect:qRect otherScale:xScale];

	TRACE_END();
	return;
	
EXCEPTION:
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

	// subtract width of yAxis label
	CGSize yAxisLabelSize = [yAxis.label size];
	skeletonRect.origin.x += yAxisLabelSize.width;
	skeletonRect.size.width -= yAxisLabelSize.width;
	
	// subtract height of xAxis label
	CGSize xAxisLabelSize = [xAxis.label size];
	skeletonRect.size.height -= xAxisLabelSize.height;

	// subtract width of yGraduationLabels
	if (yAxis.graduationLabels)
	{
		CGFloat yGraduationLabelsWidth = [GraphyGraduation maximumWidth:yAxis.graduationLabels font:yAxis.majorGraduation.labelFont];
		skeletonRect.origin.x += yGraduationLabelsWidth;
		skeletonRect.size.width -= yGraduationLabelsWidth;
	}

	// subtract height of xGraduationLabels
	if (xAxis.graduationLabels)
	{
		CGFloat xGraduationLabelsHeight = [GraphyGraduation maximumHeight:xAxis.graduationLabels font:yAxis.majorGraduation.labelFont];
		skeletonRect.size.height -= xGraduationLabelsHeight;
	}
	
	[self drawSkeleton:skeletonRect showLegend:(BOOL)qShowLegend];
	
	TRACE_END();
	return;
	
EXCEPTION:
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

	if (qShowLegend && legend)
	{
		[legend drawRect:qRect];
	} else
	{
		[self drawElements:qRect showLegend:(BOOL)qShowLegend];
	}
	
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

@end
