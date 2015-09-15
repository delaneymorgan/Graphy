//
//  GraphyLegend.h
//  Graphy
//
//  Created by Craig McFarlane on 29/11/10.
//  Copyright 2010 Delaney & Morgan Computing. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GraphyLegend : NSObject {
}

@property (strong, nonatomic) NSString* colorHeading;
@property (strong, nonatomic) NSString* labelHeading;
@property (strong, nonatomic) UIColor* headingColor;
@property (strong, nonatomic) UIColor* labelColor;
@property (strong, nonatomic) UIFont* labelFont;
@property (strong, nonatomic) NSMutableArray* colors;
@property (strong, nonatomic) NSMutableArray* names;

-(instancetype)initWithFont:(UIFont*)qLabelFont color:(UIColor*)qLabelColor;
-(BOOL)hasName:(NSString*)qName;
-(void)addName:(NSString*)qName color:(UIColor*)qColor;
-(void)drawRect:(CGRect)qRect;

@end
