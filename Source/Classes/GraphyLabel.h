//
//  GraphyLabel.h
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GraphyCoordinate;

@interface GraphyLabel : NSObject {
}

@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) UIColor* color;
@property (strong, nonatomic) UIFont* font;
@property (nonatomic) CGFloat angle;

-(instancetype)initWithText:(NSString*)qText color:(UIColor*)qColor font:(UIFont*)qFont angle:(CGFloat)qAngle;
-(void)drawAtX:(CGFloat)qXPos y:(CGFloat)qYPos coord:(GraphyCoordinate*)qCoord;
-(void)drawForXAtX:(CGFloat)qXPos y:(CGFloat)qYPos coord:(GraphyCoordinate*)qCoord;
-(void)drawForYAtX:(CGFloat)qXPos y:(CGFloat)qYPos coord:(GraphyCoordinate*)qCoord;
-(CGSize)size;

@end
