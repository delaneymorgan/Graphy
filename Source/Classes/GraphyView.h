//
//  GraphyView.h
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Graphy_defs.h"


@class GraphyGraph;
@class GraphyLabel;
@class GraphyLegend;

@interface GraphyView : UIView {
}

@property (strong, nonatomic) GraphyGraph* graph;
@property (nonatomic) BOOL showLegend;

-(void)setLegend:(GraphyLegend*)qLegend;

-(void)setPlots:(NSArray*)qPlots;
-(void)setXOrigin:(TCoordinate)qOrigin;
-(void)setYOrigin:(TCoordinate)qOrigin;
-(void)setXLabel:(GraphyLabel*)qLabel;
-(void)setYLabel:(GraphyLabel*)qLabel;
-(void)setXRangeWithMin:(TCoordinate)qMinimum max:(TCoordinate)qMaximum;
-(void)setYRangeWithMin:(TCoordinate)qMinimum max:(TCoordinate)qMaximum;

-(void)setXMajorGraduation:(TCoordinate)qIncrement;
-(void)setYMajorGraduation:(TCoordinate)qIncrement;
-(void)setXMinorGraduation:(TCoordinate)qIncrement;
-(void)setYMinorGraduation:(TCoordinate)qIncrement;
-(NSUInteger)numXMajorGraduations;
-(void)setXMajorGraduationLabels:(NSArray*)qLabels;
-(NSUInteger)numYMajorGraduations;
-(void)setYMajorGraduationLabels:(NSArray*)qLabels;

@end
