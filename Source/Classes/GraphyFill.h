//
//  GraphyFill.h
//  Powerage
//
//  Created by Craig McFarlane on 3/12/10.
//  Copyright 2010 Secure Meters. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GraphyFill : NSObject {
}

@property (strong, nonatomic) UIColor* startColor;
@property (strong, nonatomic) UIColor* endColor;
@property (strong, nonatomic) NSString* text;

-(instancetype)initWithText:(NSString*)qText startColor:(UIColor*)qStartColor endColor:(UIColor*)qEndColor;

@end
