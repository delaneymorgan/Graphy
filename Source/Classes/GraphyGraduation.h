//
//  GraphyGraduation.h
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Graphy_defs.h"


@interface GraphyGraduation : NSObject {
	TCoordinate increment;					// this graduation occurs every increment
	UIColor* color;							// color of the graduation
	TWidth width;							// width of the graduation
	CGFloat height;							// height of the graduation
	UIColor* labelColor;
	UIFont* labelFont;
}

@property (assign) TCoordinate increment;
@property (retain) UIColor* color;
@property (assign) TWidth width;
@property (assign) CGFloat height;
@property (retain) UIColor* labelColor;
@property (retain) UIFont* labelFont;

-(id)initWithIncrement:(TCoordinate)qIncrement;
-(void)drawAtPoint:(CGPoint)qPoint;
-(CGSize)graduationLabelSize;
+(CGFloat)maximumWidth:(NSArray*)qStrings font:(UIFont*)qFont;
+(CGFloat)maximumHeight:(NSArray*)qStrings font:(UIFont*)qFont;
	
@end
