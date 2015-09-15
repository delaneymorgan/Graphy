//
//  GraphyGraduation.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyGraduation.h"

#import "trace_def.h"


@implementation GraphyGraduation


#define TRACE_FLAG		(NO)

// ============================================================================================


-(instancetype)initWithIncrement:(TCoordinate)qIncrement {
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
}

// ============================================================================================

-(void)dealloc {
	self.color = nil;
	self.labelColor = nil;
	self.labelFont = nil;
}

// ============================================================================================


-(void)drawAtPoint:(CGPoint)qPoint {
	TRACE_START();
	TRACE_END();
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
	
	NSEnumerator* enumerator = [qStrings objectEnumerator];
	NSString* thisString = nil;
	while (thisString = [enumerator nextObject]) {
        CGSize thisSize = [thisString sizeWithAttributes:@{ NSFontAttributeName:qFont}];
        TRACE_CHECK( @"%@ thisSize: (w:%f, h:%f)", thisString, thisSize.width, thisSize.height);
		if (thisSize.width > maxWidth)
		{
			maxWidth = thisSize.width;
		}
	}
	ret = maxWidth;
	TRACE_END();
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
	
	NSEnumerator* enumerator = [qStrings objectEnumerator];
	NSString* thisString = nil;
	while (thisString = [enumerator nextObject]) {
        CGSize thisSize = [thisString sizeWithAttributes:@{ NSFontAttributeName:qFont}];
        TRACE_CHECK( @"%@ thisSize: (w:%f, h:%f)", thisString, thisSize.width, thisSize.height);
		if (thisSize.height > maxHeight)
		{
			maxHeight = thisSize.height;
		}
	}
	ret = maxHeight;
	TRACE_END();
	return ret;
}


@end
