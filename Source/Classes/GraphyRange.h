//
//  GraphyRange.h
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Graphy_defs.h"


@interface GraphyRange : NSObject {
}

@property (nonatomic) TCoordinate minimum;
@property (nonatomic) TCoordinate maximum;

-(instancetype)initWithMinimum:(TCoordinate)qMinimum maximum:(TCoordinate)qMaximum;

@end
