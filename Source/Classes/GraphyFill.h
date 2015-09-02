//
//  GraphyFill.h
//  Powerage
//
//  Created by Craig McFarlane on 3/12/10.
//  Copyright 2010 Secure Meters. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GraphyFill : NSObject {
	UIColor* startcolor;
	UIColor* endColor;
	NSString* text;
}

@property (retain) UIColor* startColor;
@property (retain) UIColor* endColor;
@property (retain) NSString* text;

-(id)initWithText:(NSString*)qText startColor:(UIColor*)qStartColor endColor:(UIColor*)qEndColor;

@end
