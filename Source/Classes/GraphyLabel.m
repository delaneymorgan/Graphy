//
//  GraphyLabel.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyLabel.h"

#import "trace_def.h"
#import "GraphyCoordinate.h"


@implementation GraphyLabel


#define TRACE_FLAG		(NO)

// ============================================================================================


-(instancetype)initWithText:(NSString*)qText color:(UIColor*)qColor font:(UIFont*)qFont angle:(CGFloat)qAngle {
	TRACE_START();
	
	if (self = [super init])
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
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
    TRACE_CHECK( @"Nominal Label: \"%@\" at %f:%f", self.text, qXPos, qYPos);
    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
	CGPoint textPoint = CGPointMake( [qCoord toCGXCoord:(qXPos - (textSize.width / 2))], [qCoord toCGYCoord:qYPos] + (textSize.height / 2));
	CGContextSetFillColorWithColor( context, self.color.CGColor);
    [self.text drawAtPoint:textPoint withAttributes: @{NSFontAttributeName:self.font}];
    TRACE_CHECK( @"Actual Label: \"%@\" at %f:%f", self.text, textPoint.x, textPoint.y);
	
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

// ============================================================================================


-(void)drawForXAtX:(CGFloat)qXPos y:(CGFloat)qYPos coord:(GraphyCoordinate*)qCoord {
	TRACE_START();
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
    TRACE_CHECK( @"Nominal Label: \"%@\" at %f:%f", self.text, qXPos, qYPos);
    NSDictionary* attributes = @{ NSForegroundColorAttributeName:self.color, NSFontAttributeName:self.font};
    CGSize textSize = [self.text sizeWithAttributes:attributes];
	CGPoint textPoint = CGPointMake( [qCoord toCGXCoord:(qXPos - (textSize.width / 2))], qYPos + (textSize.height / 2));
	CGContextSetFillColorWithColor( context, self.color.CGColor);
    [self.text drawAtPoint:textPoint withAttributes:attributes];
    TRACE_CHECK( @"Actual Label: \"%@\" at %f:%f", self.text, textPoint.x, textPoint.y);
	
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

// ============================================================================================


-(void)drawForYAtX:(CGFloat)qXPos y:(CGFloat)qYPos coord:(GraphyCoordinate*)qCoord {
	TRACE_START();
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
    TRACE_CHECK( @"Nominal Label: \"%@\" at %f:%f", self.text, qXPos, qYPos);
    TRACE_CHECK( @"%@", @{ NSFontAttributeName:self.font});
    NSDictionary* attributes = @{ NSForegroundColorAttributeName:self.color, NSFontAttributeName:self.font};
    CGSize textSize = [self.text sizeWithAttributes:attributes];
	CGPoint textPoint = CGPointMake( (qXPos - (textSize.width / 2)), [qCoord toCGYCoord:qYPos] + (textSize.height / 2));
	CGContextSetFillColorWithColor( context, self.color.CGColor);
    [self.text drawAtPoint:textPoint withAttributes:attributes];
    TRACE_CHECK( @"Actual Label: \"%@\" at %f:%f", self.text, textPoint.x, textPoint.y);
	
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

// ============================================================================================


-(CGSize)size {
	CGSize ret;
	
	TRACE_START();
	
    CGSize textSize = [self.text sizeWithAttributes:@{ NSFontAttributeName:self.font}];
	ret = textSize;
	
	TRACE_END();
	return ret;
}

@end
