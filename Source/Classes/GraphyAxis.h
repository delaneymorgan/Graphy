//
//  GraphyAxis.h
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Graphy_defs.h"


@class GraphyLabel;
@class GraphyGraduation;
@class GraphyRange;
@class GraphyScale;

@interface GraphyAxis : NSObject {
}

@property (strong, nonatomic) GraphyLabel* label;
@property (nonatomic) TCoordinate origin;
@property (strong, nonatomic) GraphyLabel* labeller;
@property (strong, nonatomic) GraphyRange* range;
@property (strong, nonatomic) GraphyScale* scale;
@property (strong, nonatomic) GraphyGraduation* majorGraduation;
@property (strong, nonatomic) GraphyGraduation* minorGraduation;
@property (strong, nonatomic) UIColor* color;
@property (nonatomic) TWidth axisWidth;
@property (strong, nonatomic) NSArray* graduationLabels;

-(instancetype)init;
-(instancetype)initWithOrigin:(TCoordinate)qOrigin;
-(void)drawRect:(CGRect)rect otherScale:(GraphyScale*)qOtherScale;

@end
