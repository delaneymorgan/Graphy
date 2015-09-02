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
	TCoordinate numerator;
	TCoordinate denominator;
	TCoordinate ratio;
}

@property (assign, nonatomic) TCoordinate numerator;
@property (assign, nonatomic) TCoordinate denominator;
@property (assign, nonatomic) TCoordinate ratio;

-(id)initWithNumerator:(TCoordinate)qNumerator denominator:(TCoordinate)qDenominator;
-(TCoordinate)scale:(TCoordinate)qUnscaledValue;
-(TCoordinate)descale:(TCoordinate)qScaledValue;

@end
