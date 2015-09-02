//
//  GraphyLegend.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyLegend.h"

#import "trace_def.h"
#import "dbc_def.h"
//#import "UIColor-Expanded.h"
#import "GraphyGraduation.h"


@implementation GraphyLegend

@synthesize colorHeading;
@synthesize labelHeading;
@synthesize headingColor;
@synthesize labelColor;
@synthesize labelFont;
@synthesize colors;
@synthesize names;


#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)initWithFont:(UIFont*)qLabelFont color:(UIColor*)qLabelColor {
	TRACE_START();
	if ([super init])
	{
		self.headingColor = [UIColor whiteColor];
		self.labelFont = qLabelFont;
		self.labelColor = qLabelColor;
		self.names = [[NSMutableArray alloc] init];
		self.colors = [[NSMutableArray alloc] init];
	}
	TRACE_END();
	return self;
}

// ============================================================================================


-(void)dealloc {
	TRACE_START();
	self.colorHeading = nil;
	self.labelHeading = nil;
	self.headingColor = nil;
	self.labelColor = nil;
	self.labelFont = nil;
	self.colors = nil;
	self.names = nil;
	[super dealloc];
	TRACE_END();
}

// ============================================================================================


-(BOOL)hasName:(NSString*)qName {
	BOOL ret = NO;
	
	TRACE_START();
	
	PRECONDITION( qName);
	
	if ([names containsObject:qName]) {
		ret = YES;
	}
	TRACE_END();
	return ret;
	
EXCEPTION:
	return ret;
}

// ============================================================================================


-(void)addName:(NSString*)qName color:(UIColor*)qColor {
	TRACE_START();
	
	PRECONDITION( qName);
	PRECONDITION( qColor);
	
	[names addObject:qName];
	[colors addObject:qColor];
	
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

// ============================================================================================


-(void)drawRect:(CGRect)qRect {
	const CGFloat kColorLabelGap = 30.00;
	
	TRACE_START();
	
	PRECONDITION( [names count] == [colors count]);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	MIDCONDITION( context);

	NSUInteger numPairs = [names count];
	if (labelHeading)
	{
		numPairs++;		// room for headings
	}
	CGFloat pairHeight = qRect.size.height / numPairs;
	
	CGContextSetFillColorWithColor( context, [UIColor blackColor].CGColor);
	CGContextFillRect( context, qRect);
	CGFloat maxLabelWidth = [GraphyGraduation maximumWidth:names font:labelFont];
	if (labelHeading)
	{
//		CGSize thisSize = [labelHeading sizeWithFont:labelFont];
        CGSize thisSize = [labelHeading sizeWithAttributes:@{ NSFontAttributeName:labelFont}];
		if (thisSize.width > maxLabelWidth)
		{
			maxLabelWidth = thisSize.width;
		}
	}
//	CGSize thisSize = [colorHeading sizeWithFont:labelFont];
    CGSize thisSize = [colorHeading sizeWithAttributes:@{ NSFontAttributeName:labelFont}];
	CGFloat swatchWidth = thisSize.width;
	if (pairHeight > swatchWidth)
	{
		swatchWidth = pairHeight;
	}
	
	for ( NSUInteger pairNo = 0; pairNo < numPairs; pairNo++)
	{
		UIColor* thisColor = nil;
		NSString* thisName = nil;
		CGRect pairRect = CGRectMake( qRect.origin.x,
									 qRect.origin.y + ( pairNo * pairHeight),
									 qRect.size.width,
									 pairHeight);
		
		if (labelHeading)
		{
			if (!pairNo)
			{
				// draw headings
				thisColor = headingColor;
				thisName = labelHeading;
			}
			else
			{
				thisColor = [colors objectAtIndex:pairNo - 1];
				thisName = [names objectAtIndex:pairNo - 1];
			}
		}
		else
		{
			thisColor = [colors objectAtIndex:pairNo];
			thisName = [names objectAtIndex:pairNo];
		}

		if (labelHeading && !pairNo)
		{
			// draw color heading
			CGPoint textPoint;
			textPoint.x = pairRect.origin.x + (pairRect.size.width / 2) - swatchWidth - (kColorLabelGap / 2);
			textPoint.y = pairRect.origin.y + ( pairRect.size.height / 2) - labelFont.ascender + ( labelFont.capHeight / 2);
			CGContextSetFillColorWithColor( context, headingColor.CGColor);
			CGContextSetStrokeColorWithColor( context, headingColor.CGColor);
//			[colorHeading drawAtPoint:textPoint withFont:labelFont];	// draws from tl corner, not base-line as you might expect
            [colorHeading drawAtPoint:textPoint withAttributes: @{NSFontAttributeName: labelFont}];
		}
		else
		{
			// draw swatch
			CGRect swatchRect = pairRect;
			swatchRect.origin.x = pairRect.origin.x + (pairRect.size.width / 2) - swatchWidth - (kColorLabelGap / 2);
			swatchRect.size.width = swatchWidth;
			CGContextSetFillColorWithColor( context, thisColor.CGColor);
			CGContextSetStrokeColorWithColor( context, thisColor.CGColor);
			CGContextFillRect( context, swatchRect);
		}
		
		// draw name
		CGPoint textPoint;
		TRACE_CHECK( @"labelFont.capHeight: %f", labelFont.capHeight);
		TRACE_CHECK( @"labelFont.ascender: %f", labelFont.ascender);
		textPoint.x = pairRect.origin.x + ( ( pairRect.size.width + kColorLabelGap) / 2);
		textPoint.y = pairRect.origin.y + ( pairRect.size.height / 2) - labelFont.ascender + ( labelFont.capHeight / 2);
		CGContextSetFillColorWithColor( context, labelColor.CGColor);
		CGContextSetStrokeColorWithColor( context, labelColor.CGColor);
//		[thisName drawAtPoint:textPoint withFont:labelFont];	// draws from tl corner, not base-line as you might expect
        [thisName drawAtPoint:textPoint withAttributes: @{NSFontAttributeName: labelFont}];
	}
	
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

@end
