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
}

@property (nonatomic) TCoordinate increment;
@property (strong, nonatomic) UIColor* color;
@property (nonatomic) TWidth width;
@property (nonatomic) CGFloat height;
@property (strong, nonatomic) UIColor* labelColor;
@property (strong, nonatomic) UIFont* labelFont;

-(instancetype)initWithIncrement:(TCoordinate)qIncrement;
-(void)drawAtPoint:(CGPoint)qPoint;
-(CGSize)graduationLabelSize;
+(CGFloat)maximumWidth:(NSArray*)qStrings font:(UIFont*)qFont;
+(CGFloat)maximumHeight:(NSArray*)qStrings font:(UIFont*)qFont;
	
@end
