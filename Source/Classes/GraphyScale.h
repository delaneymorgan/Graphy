//
//  GraphyScale.h
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Graphy_defs.h"


@interface GraphyScale : NSObject {
}

@property (nonatomic) TCoordinate numerator;
@property (nonatomic) TCoordinate denominator;
@property (nonatomic) TCoordinate ratio;

-(instancetype)initWithNumerator:(TCoordinate)qNumerator denominator:(TCoordinate)qDenominator;
-(TCoordinate)scale:(TCoordinate)qUnscaledValue;
-(TCoordinate)descale:(TCoordinate)qScaledValue;

@end
