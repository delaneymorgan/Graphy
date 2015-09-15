//
//  ColorPickerViewController.h
//  Powerage
//
//  Created by Craig McFarlane on 7/10/10.
//  Copyright 2010 Secure Australasia. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kStandardColor_Red			@"redColor"
#define kStandardColor_Green		@"greenColor"
#define kStandardColor_Blue			@"blueColor"
#define kStandardColor_Cyan			@"cyanColor"
#define kStandardColor_Yellow		@"yellowColor"
#define kStandardColor_Magenta		@"magentaColor"
#define kStandardColor_Orange		@"orangeColor"
#define kStandardColor_Purple		@"purpleColor"
#define kStandardColor_Brown		@"brownColor"


@interface ColorPickerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
}

@property (weak, nonatomic) IBOutlet UITableView* colorOutlet;
@property (strong, nonatomic) NSDictionary* colorList;
@property (strong, nonatomic) NSDictionary* colorNames;
@property (strong, nonatomic) NSMutableString* selectedColor;

-(id)initWithNibName:(NSString*)qNibName;
+(UIColor*)newColor:(NSString*)qColorName;
+(NSArray*)availableColors;

@end
