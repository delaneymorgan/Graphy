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
	TCoordinate baseCoord;
	GraphyLabel* label;
	NSArray* parts;
	CGFloat width;
}

@property (assign) TCoordinate baseCoord;
@property (retain) GraphyLabel* label;
@property (retain) NSArray* parts;
@property (assign) CGFloat width;

-(id)initWithBaseCoord:(TCoordinate)qBaseCoord width:(CGFloat)qWidth label:(GraphyLabel*)qLabel parts:(NSArray*)qParts;

@end
