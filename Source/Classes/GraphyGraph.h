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
}

@property (strong, nonatomic) GraphyXAxis* xAxis;
@property (strong, nonatomic) GraphyYAxis* yAxis;
@property (strong, nonatomic) NSArray* plots;
@property (strong, nonatomic) GraphyLegend* legend;

-(instancetype)init;
-(void)drawRect:(CGRect)qRect showLegend:(BOOL)qShowLegend;
	
@end
