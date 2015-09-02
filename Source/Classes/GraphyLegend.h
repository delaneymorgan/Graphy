//
//  GraphyLegend.h
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GraphyLegend : NSObject {
	NSString* colorHeading;
	NSString* labelHeading;
	UIColor* headingColor;
	UIColor* labelColor;
	UIFont* labelFont;
	NSMutableArray* colors;
	NSMutableArray* names;
}

@property (retain) NSString* colorHeading;
@property (retain) NSString* labelHeading;
@property (retain) UIColor* headingColor;
@property (retain) UIColor* labelColor;
@property (retain) UIFont* labelFont;
@property (retain) NSMutableArray* colors;
@property (retain) NSMutableArray* names;

-(id)initWithFont:(UIFont*)qLabelFont color:(UIColor*)qLabelColor;
-(BOOL)hasName:(NSString*)qName;
-(void)addName:(NSString*)qName color:(UIColor*)qColor;
-(void)drawRect:(CGRect)qRect;

@end
