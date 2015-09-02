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
	TCoordinate minimum;
	TCoordinate maximum;
}

@property (assign) TCoordinate minimum;
@property (assign) TCoordinate maximum;

-(id)initWithMinimum:(TCoordinate)qMinimum maximum:(TCoordinate)qMaximum;

@end
