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
	GraphyFill* fill;
	TCoordinate value;
}

@property (retain) GraphyFill* fill;
@property (assign) TCoordinate value;

-(id)initWithValue:(TCoordinate)qValue fill:(GraphyFill*)qFill;

@end
