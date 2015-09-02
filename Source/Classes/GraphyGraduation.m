//
//  GraphyGraduation.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyGraduation.h"

#import "dbc_def.h"
#import "trace_def.h"


@implementation GraphyGraduation

@synthesize increment;
@synthesize color;
@synthesize width;
@synthesize height;
@synthesize labelColor;
@synthesize labelFont;


#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)initWithIncrement:(TCoordinate)qIncrement {
	TRACE_START();
	
	if (self = [super init]) {
		self.increment = qIncrement;
		self.color = [UIColor blueColor];
		self.width = 1.0;
		self.height = 5.0;
		self.labelColor = [UIColor whiteColor];
		self.labelFont = [UIFont systemFontOfSize:12];
    }
	TRACE_END();
	return self;
	
EXCEPTION:
	return self;
}

// ============================================================================================

-(void)dealloc {
	self.color = nil;
	self.labelColor = nil;
	self.labelFont = nil;
	[super dealloc];
}

// ============================================================================================


-(void)drawAtPoint:(CGPoint)qPoint {
	TRACE_START();
	FAIL;
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

// ============================================================================================


-(CGSize)graduationLabelSize {
	CGSize ret;
	
	TRACE_START();
	// +=+ get label size with dummy string
	TRACE_END();
	return ret;
}

// ============================================================================================


/**
 * find the widest string in the array of strings
 *
 * @param qStrings the strings to be checked
 * @param qFont the font to be used for calculations
 * @return CGFloat the widest width
 */
+(CGFloat)maximumWidth:(NSArray*)qStrings font:(UIFont*)qFont {
	CGFloat ret = 0.0;
	CGFloat maxWidth = 0.0;
	
	TRACE_START();
	
	PRECONDITION( qStrings);
	PRECONDITION( qFont);
	
	NSEnumerator* enumerator = [qStrings objectEnumerator];
	NSString* thisString = nil;
	while (thisString = [enumerator nextObject]) {
//		CGSize thisSize = [thisString sizeWithFont:qFont];
        CGSize thisSize = [thisString sizeWithAttributes:@{ NSFontAttributeName:qFont}];
		if (thisSize.width > maxWidth)
		{
			maxWidth = thisSize.width;
		}
	}
	ret = maxWidth;
	TRACE_END();
	return ret;
	
EXCEPTION:
	return ret;
}

// ============================================================================================


/**
 * find the highest string in the array of strings
 *
 * @param qStrings the strings to be checked
 * @param qFont the font to be used for calculations
 * @return CGFloat the highest height
 */
+(CGFloat)maximumHeight:(NSArray*)qStrings font:(UIFont*)qFont {
	CGFloat ret = 0.0;
	CGFloat maxHeight = 0.0;
	
	TRACE_START();
	
	PRECONDITION( qStrings);
	PRECONDITION( qFont);
	
	NSEnumerator* enumerator = [qStrings objectEnumerator];
	NSString* thisString = nil;
	while (thisString = [enumerator nextObject]) {
//		CGSize thisSize = [thisString sizeWithFont:qFont];
        CGSize thisSize = [thisString sizeWithAttributes:@{ NSFontAttributeName:qFont}];
		if (thisSize.height > maxHeight)
		{
			maxHeight = thisSize.height;
		}
	}
	ret = maxHeight;
	TRACE_END();
	return ret;
	
EXCEPTION:
	return ret;
}

// ============================================================================================




@end
