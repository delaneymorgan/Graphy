//
//  GraphyCoordinate.h
//  Powerage
//
//  Created by Craig McFarlane on 1/12/10.
//  Copyright 2010 Secure Meters. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Graphy_defs.h"


@interface GraphyCoordinate : NSObject {
}

@property (nonatomic) CGRect frame;

-(instancetype)initWithFrame:(CGRect)qFrame;
-(CGFloat)toCGXCoord:(TCoordinate)qGraphCoord;
-(CGFloat)toCGYCoord:(TCoordinate)qGraphCoord;
+(CGFloat)toCGXCoord:(TCoordinate)qGraphCoord frame:(CGRect)qFrame;
+(CGFloat)toCGYCoord:(TCoordinate)qGraphCoord frame:(CGRect)qFrame;

@end
