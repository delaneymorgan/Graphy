//
//  GraphyGraph.h
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Graphy_defs.h"


@class GraphyXAxis;
@class GraphyYAxis;
@class GraphyLegend;
@class GraphyLabel;

@interface GraphyGraph : NSObject {
	GraphyXAxis* xAxis;
	GraphyYAxis* yAxis;
	NSArray* plots;
	GraphyLegend* legend;
}

@property (retain) GraphyXAxis* xAxis;
@property (retain) GraphyYAxis* yAxis;
@property (retain) NSArray* plots;
@property (retain) GraphyLegend* legend;

-(id)init;
-(void)drawRect:(CGRect)qRect showLegend:(BOOL)qShowLegend;
	
@end
