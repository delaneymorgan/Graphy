//
//  GraphyPlotPart.h
//  Powerage
//
//  Created by Craig McFarlane on 3/12/10.
//  Copyright 2010 Secure Meters. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Graphy_defs.h"


@class GraphyFill;

@interface GraphyPlotPart : NSObject {
}

@property (strong, nonatomic) GraphyFill* fill;
@property (nonatomic) TCoordinate value;

-(instancetype)initWithValue:(TCoordinate)qValue fill:(GraphyFill*)qFill;

@end
