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
	GraphyLabel* label;
	TCoordinate origin;
	GraphyLabel* labeller;
	GraphyRange* range;
	GraphyScale* scale;
	GraphyGraduation* majorGraduation;
	GraphyGraduation* minorGraduation;
	UIColor* color;
	TWidth axisWidth;
	NSArray* graduationLabels;
}

@property (retain) GraphyLabel* label;
@property (assign) TCoordinate origin;
@property (retain) GraphyLabel* labeller;
@property (retain) GraphyRange* range;
@property (retain) GraphyScale* scale;
@property (retain) GraphyGraduation* majorGraduation;
@property (retain) GraphyGraduation* minorGraduation;
@property (retain) UIColor* color;
@property (assign) TWidth axisWidth;
@property (retain) NSArray* graduationLabels;

-(id)init;
-(id)initWithOrigin:(TCoordinate)qOrigin;
-(void)drawRect:(CGRect)rect otherScale:(GraphyScale*)qOtherScale;

@end
