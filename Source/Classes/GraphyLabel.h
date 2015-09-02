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
	NSString* text;
	UIColor* color;
	UIFont* font;
	CGFloat angle;
}

@property (retain) NSString* text;
@property (retain) UIColor* color;
@property (retain) UIFont* font;
@property (assign) CGFloat angle;

-(id)initWithText:(NSString*)qText color:(UIColor*)qColor font:(UIFont*)qFont angle:(CGFloat)qAngle;
-(void)drawAtX:(CGFloat)qXPos y:(CGFloat)qYPos coord:(GraphyCoordinate*)qCoord;
-(void)drawForXAtX:(CGFloat)qXPos y:(CGFloat)qYPos coord:(GraphyCoordinate*)qCoord;
-(void)drawForYAtX:(CGFloat)qXPos y:(CGFloat)qYPos coord:(GraphyCoordinate*)qCoord;
-(CGSize)size;

@end
