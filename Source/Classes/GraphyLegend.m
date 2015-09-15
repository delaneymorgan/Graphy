//
//  GraphyLegend.m
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import "GraphyLegend.h"

#import "trace_def.h"
#import "GraphyGraduation.h"


@implementation GraphyLegend


@synthesize names = _names;
@synthesize colors = _colors;


#define TRACE_FLAG		(NO)

// ============================================================================================


-(instancetype)initWithFont:(UIFont*)qLabelFont color:(UIColor*)qLabelColor {
	TRACE_START();
	if (self = [super init])
	{
		self.headingColor = [UIColor whiteColor];
		self.labelFont = qLabelFont;
		self.labelColor = qLabelColor;
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
	TRACE_END();
}

// ============================================================================================


-(NSMutableArray*)names {
    if (!_names) {
        _names = [[NSMutableArray alloc] init];
    }
    return _names;
}

// ============================================================================================


-(NSMutableArray*)colors {
    if (!_colors) {
        _colors = [[NSMutableArray alloc] init];
    }
    return _colors;
}

// ============================================================================================


-(BOOL)hasName:(NSString*)qName {
	BOOL ret = NO;
	
	TRACE_START();
	
	if ([self.names containsObject:qName]) {
		ret = YES;
	}
	TRACE_END();
	return ret;
}

// ============================================================================================


-(void)addName:(NSString*)qName color:(UIColor*)qColor {
	TRACE_START();
	
	[self.names addObject:qName];
	[self.colors addObject:qColor];
	
	TRACE_END();
	return;
}

// ============================================================================================


-(void)drawRect:(CGRect)qRect {
	const CGFloat kColorLabelGap = 30.00;
	
	TRACE_START();
	
	CGContextRef context = UIGraphicsGetCurrentContext();

	NSUInteger numPairs = [self.names count];
	if (self.labelHeading)
	{
		numPairs++;		// room for headings
	}
	CGFloat pairHeight = qRect.size.height / numPairs;
	
	CGContextSetFillColorWithColor( context, [UIColor blackColor].CGColor);
	CGContextFillRect( context, qRect);

    NSDictionary* attributes = @{ NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:self.labelFont};
    CGSize thisSize = [self.colorHeading sizeWithAttributes:attributes];
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
		
		if (self.labelHeading)
		{
			if (!pairNo)
			{
				// draw headings
				thisColor = self.headingColor;
				thisName = self.labelHeading;
			}
			else
			{
				thisColor = [self.colors objectAtIndex:pairNo - 1];
				thisName = [self.names objectAtIndex:pairNo - 1];
			}
		}
		else
		{
			thisColor = [self.colors objectAtIndex:pairNo];
			thisName = [self.names objectAtIndex:pairNo];
		}

		if (self.labelHeading && !pairNo)
		{
			// draw color heading
			CGPoint textPoint;
			textPoint.x = pairRect.origin.x + (pairRect.size.width / 2) - swatchWidth - (kColorLabelGap / 2);
			textPoint.y = pairRect.origin.y + ( pairRect.size.height / 2) - self.labelFont.ascender + ( self.labelFont.capHeight / 2);
			CGContextSetFillColorWithColor( context, self.headingColor.CGColor);
			CGContextSetStrokeColorWithColor( context, self.headingColor.CGColor);
            NSDictionary* attributes = @{ NSForegroundColorAttributeName:self.labelColor, NSFontAttributeName:self.labelFont};
            [self.colorHeading drawAtPoint:textPoint withAttributes:attributes];
            TRACE_CHECK( @"self.colorHeading: %@", self.colorHeading);
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
		TRACE_CHECK( @"labelFont.capHeight: %f", self.labelFont.capHeight);
		TRACE_CHECK( @"labelFont.ascender: %f", self.labelFont.ascender);
		textPoint.x = pairRect.origin.x + ( ( pairRect.size.width + kColorLabelGap) / 2);
		textPoint.y = pairRect.origin.y + ( pairRect.size.height / 2) - self.labelFont.ascender + ( self.labelFont.capHeight / 2);
		CGContextSetFillColorWithColor( context, self.labelColor.CGColor);
		CGContextSetStrokeColorWithColor( context, self.labelColor.CGColor);
        NSDictionary* attributes = @{ NSForegroundColorAttributeName:self.labelColor, NSFontAttributeName:self.labelFont};
        [thisName drawAtPoint:textPoint withAttributes:attributes];
        TRACE_CHECK( @"thisName: %@", thisName);
	}
	
	TRACE_END();
	return;
}

@end
