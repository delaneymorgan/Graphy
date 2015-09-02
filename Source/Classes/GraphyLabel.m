//
//  GraphyLabel.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyLabel.h"

#import "trace_def.h"
#import "dbc_def.h"
#import "GraphyCoordinate.h"
#import "UIColor-Expanded.h"


@implementation GraphyLabel

@synthesize text;
@synthesize color;
@synthesize font;
@synthesize angle;


#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)initWithText:(NSString*)qText color:(UIColor*)qColor font:(UIFont*)qFont angle:(CGFloat)qAngle {
	TRACE_START();
	
	if ([super init])
	{
		self.text = qText;
		self.color = qColor;
		self.font = qFont;
		self.angle = qAngle;
	}
	TRACE_END();
	return self;
}

// ============================================================================================


-(void)drawAtX:(CGFloat)qXPos y:(CGFloat)qYPos coord:(GraphyCoordinate*)qCoord {
	TRACE_START();
	
	PRECONDITION( qCoord);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	MIDCONDITION( context);
	
	CGSize textSize = [text sizeWithFont:font];
	CGPoint textPoint = CGPointMake( [qCoord toCGXCoord:(qXPos - (textSize.width / 2))], [qCoord toCGYCoord:qYPos] + (textSize.height / 2));
	TRACE_CHECK( @"color: %@", [color stringFromColor]);
	CGContextSetFillColorWithColor( context, color.CGColor);
	[text drawAtPoint:textPoint withFont:font]; 
	
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

// ============================================================================================


-(void)drawForXAtX:(CGFloat)qXPos y:(CGFloat)qYPos coord:(GraphyCoordinate*)qCoord {
	TRACE_START();
	
	PRECONDITION( qCoord);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	MIDCONDITION( context);
	
	CGSize textSize = [text sizeWithFont:font];
	CGPoint textPoint = CGPointMake( [qCoord toCGXCoord:(qXPos - (textSize.width / 2))], qYPos + (textSize.height / 2));
	TRACE_CHECK( @"color: %@", [color stringFromColor]);
	CGContextSetFillColorWithColor( context, color.CGColor);
	[text drawAtPoint:textPoint withFont:font]; 
	
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

// ============================================================================================


-(void)drawForYAtX:(CGFloat)qXPos y:(CGFloat)qYPos coord:(GraphyCoordinate*)qCoord {
	TRACE_START();
	
	PRECONDITION( qCoord);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	MIDCONDITION( context);
	
	CGSize textSize = [text sizeWithFont:font];
	CGPoint textPoint = CGPointMake( (qXPos - (textSize.width / 2)), [qCoord toCGYCoord:qYPos] + (textSize.height / 2));
	TRACE_CHECK( @"color: %@", [color stringFromColor]);
	CGContextSetFillColorWithColor( context, color.CGColor);
	[text drawAtPoint:textPoint withFont:font]; 
	
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

// ============================================================================================


-(CGSize)size {
	CGSize ret;
	
	TRACE_START();
	
	CGSize textSize = [text sizeWithFont:font];
	ret = textSize;
	
	TRACE_END();
	return ret;
}

@end
