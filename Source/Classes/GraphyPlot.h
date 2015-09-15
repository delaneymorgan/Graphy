//
//  GraphyPlot.h
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Graphy_defs.h"


@class GraphyLabel;

@interface GraphyPlot : NSObject {
}

@property (nonatomic) TCoordinate baseCoord;
@property (strong, nonatomic) GraphyLabel* label;
@property (strong, nonatomic) NSArray* parts;
@property (nonatomic) CGFloat width;

-(instancetype)initWithBaseCoord:(TCoordinate)qBaseCoord width:(CGFloat)qWidth label:(GraphyLabel*)qLabel parts:(NSArray*)qParts;

@end
