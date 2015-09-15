//
//  ColorPickerViewController.m
//  Powerage
//
//  Created by Craig McFarlane on 7/10/10.
//  Copyright 2010 Secure Australasia. All rights reserved.
//

#import "ColorPickerViewController.h"

#import "dbc_def.h"
#import "trace_def.h"


@implementation ColorPickerViewController

@synthesize colorOutlet;
@synthesize colorList;
@synthesize colorNames;
@synthesize selectedColor;

#define kColorPickerCellNameTag			1000
#define kColorPickerCellColorTag		1001

#define kLS_Red					@"Red"
#define kLS_Green				@"Green"
#define kLS_Blue				@"Blue"
#define kLS_Cyan				@"Cyan"
#define kLS_Yellow				@"Yellow"
#define kLS_Magenta				@"Magenta"
#define kLS_Orange				@"Orange"
#define kLS_Purple				@"Purple"
#define kLS_Brown				@"Brown"


#define TRACE_FLAG		(NO)

// ============================================================================================


-(id)initWithNibName:(NSString*)qNibName {
	TRACE_START();
    if ((self = [super initWithNibName:qNibName bundle:nil])) {
        // Custom initialization
		colorList = [[NSDictionary alloc] initWithObjectsAndKeys:
					 [UIColor redColor], kStandardColor_Red,
					 [UIColor greenColor], kStandardColor_Green,
					 [UIColor blueColor], kStandardColor_Blue,
					 [UIColor cyanColor], kStandardColor_Cyan,
					 [UIColor yellowColor], kStandardColor_Yellow,
					 [UIColor magentaColor], kStandardColor_Magenta,
					 [UIColor orangeColor], kStandardColor_Orange,
					 [UIColor purpleColor], kStandardColor_Purple,
					 [UIColor brownColor], kStandardColor_Brown,
					 nil];
		colorNames = [[NSDictionary alloc] initWithObjectsAndKeys:
					  NSLocalizedString( kLS_Red, kLS_Red), kStandardColor_Red,
					  NSLocalizedString( kLS_Green, kLS_Green), kStandardColor_Green,
					  NSLocalizedString( kLS_Blue, kLS_Blue), kStandardColor_Blue,
					  NSLocalizedString( kLS_Cyan, kLS_Cyan), kStandardColor_Cyan,
					  NSLocalizedString( kLS_Yellow, kLS_Yellow), kStandardColor_Yellow,
					  NSLocalizedString( kLS_Magenta, kLS_Magenta), kStandardColor_Magenta,
					  NSLocalizedString( kLS_Orange, kLS_Orange), kStandardColor_Orange,
					  NSLocalizedString( kLS_Purple, kLS_Purple), kStandardColor_Purple,
					  NSLocalizedString( kLS_Brown, kLS_Brown), kStandardColor_Brown,
					 nil];
		self.selectedColor = nil;
		TRACE_CHECK( @"selectedColor: %p", selectedColor);
    }
	TRACE_END();
    return self;

EXCEPTION:
	return self;
}

// ============================================================================================


/**
 * Returns the number of rows in the locations list
 * i.e. the number of locations.
 *
 * @param tableView the person list table view
 * @param NSInteger the section number
 * @return NSInteger the number of rows in this table section
 */
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger ret = 0;
	
	TRACE_START();
	
	ret = [colorList count];
	TRACE_CHECK( @"number of rows = %d", ret);
	TRACE_END();
	return ret;
	
EXCEPTION:
	return ret;
}

// ============================================================================================


/**
 * create a new table view cell to hold a color
 *
 * @param tableView the new cell's tableview
 * @return UITableViewCell* the new cell
 */
-(UITableViewCell*)newColorCell:(UITableView*)tableView {
	UITableViewCell* ret = nil;
	UITableViewCell* thisCell = nil;
	
	TRACE_START();
	
	NSArray* cellNib = [[NSBundle mainBundle] loadNibNamed:NIBName( kNIBColorPickerCellView) owner:self options:nil];
	MIDCONDITION( cellNib);
	TRACE_CHECK( @"nib loaded");
	id firstObject = [cellNib objectAtIndex:0];
	MIDCONDITION( [firstObject isKindOfClass:[UITableViewCell class]]);
	thisCell = (UITableViewCell*)[cellNib objectAtIndex:0];
	MIDCONDITION( thisCell);
	TRACE_CHECK( @"cell from nib loaded");
	
	ret = thisCell;
	
	TRACE_END();
	return ret;
	
EXCEPTION:
	RELEASEIF( thisCell);
	return ret;
}

// ============================================================================================


/**
 * retrieve the cell for the specified index, creating it if neccessary
 *
 * @param tableView the cell's tableview
 * @param indexPath the cell's indexpath
 * @return UITableViewCell* the cell
 */
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
	UITableViewCell* ret = nil;
	UITableViewCell* thisCell = nil;
	
	TRACE_START();
	
	NSMutableArray* colorKeys = [NSMutableArray arrayWithArray:[colorList allKeys]];
	MIDCONDITION( colorKeys);
	[colorKeys sortUsingSelector:@selector(compare:)];
	TRACE_CHECK( @"row = %d", indexPath.row);
	
	thisCell = [tableView dequeueReusableCellWithIdentifier:kColorCellReuseID];
	if (!thisCell) {
		thisCell = [self newColorCell:tableView];
	}
	thisCell.imageView.image = nil;
	NSString* thisColor = [colorKeys objectAtIndex:indexPath.row];
	MIDCONDITION( thisColor);
	TRACE_CHECK( @"thisColor: %@", thisColor);
	UIColor* color = [colorList objectForKey:thisColor];

	// name
	UILabel* nameLabel = (UILabel*) [thisCell viewWithTag:kColorPickerCellNameTag];
	MIDCONDITION( nameLabel);
	nameLabel.text = [colorNames objectForKey:thisColor];
	
	// color
	UILabel* colorLabel = (UILabel*) [thisCell viewWithTag:kColorPickerCellColorTag];
	MIDCONDITION( colorLabel);
	colorLabel.backgroundColor = color;
	
	TRACE_CHECK( @"selectedColor: %@", selectedColor);
	TRACE_CHECK( @"thisColor: %@", thisColor);
	if ([selectedColor isEqualToString:thisColor])
	{
		thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else
	{
		thisCell.accessoryType = UITableViewCellAccessoryNone;
	}

	ret = thisCell;
	TRACE_END();
	return ret;
	
EXCEPTION:
	RELEASEIF( thisCell);
	return ret;
}

// ============================================================================================


/**
 * handles cell selection for the specified table view
 *
 * @param tableView the cell's tableview
 * @param indexPath the cell's indexpath
 */
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
	TRACE_START();
	
	NSMutableArray* colorKeys = [NSMutableArray arrayWithArray:[colorList allKeys]];
	MIDCONDITION( colorKeys);
	[colorKeys sortUsingSelector:@selector(compare:)];
	TRACE_CHECK( @"row = %d", indexPath.row);
	self.selectedColor = [colorKeys objectAtIndex:indexPath.row];
	TRACE_CHECK( @"selectedColor: %@", selectedColor);
	[colorOutlet reloadData];
	[[NSNotificationCenter defaultCenter] postNotificationName:kTariffsChangedNotification object:nil];
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

// ============================================================================================


-(void)setSelectedColor:(NSMutableString*)qNewColor {
	TRACE_START();
	if (!qNewColor && selectedColor)
	{
		[selectedColor release];
		selectedColor = nil;
	}
	if (!selectedColor)
	{
		selectedColor = qNewColor;
		[selectedColor retain];
	}
	[selectedColor setString:qNewColor];
	[colorOutlet reloadData];
	[self.navigationController popViewControllerAnimated:YES];
	TRACE_END();
	return;
	
EXCEPTION:
	return;
}

// ============================================================================================


/**
 * the nib has been loaded
 */
-(void)viewDidLoad {
	TRACE_START();
    [super viewDidLoad];
	TRACE_END();
}

// ============================================================================================


/**
 * Override to allow orientations other than the default portrait orientation.
 *
 * @param qOrientation the orientation being queried
 * @return BOOL YES => supported, NO => not supported
 */
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)qOrientation
{
	BOOL ret = NO;
	
	TRACE_START();
	
	ret = IsOrientationSupported( qOrientation);
	TRACE_END();
    return ret;
}

// ============================================================================================


-(void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

// ============================================================================================


- (void)dealloc {
	self.colorList = nil;
	self.colorNames = nil;
	self.colorOutlet = nil;
	self.selectedColor = nil;
    [super dealloc];
}

// ============================================================================================


/**
 * takes the color name and returns a color object
 *
 * @param qName the name of the color
 * @return UIColor* the actual color value for that name
 */
+(UIColor*)newColor:(NSString*)qColorName {
	UIColor* ret = nil;
	
	TRACE_START();
	
	PRECONDITION( qColorName);
	SEL mySel = NSSelectorFromString( qColorName);
	
	ret = [UIColor performSelector:mySel];
	TRACE_END();
	return ret;

EXCEPTION:
	return ret;
}

// ============================================================================================


/**
 * return a list of available colors
 *
 * @return NSArray* the array of color names
 */
+(NSArray*)availableColors {
	NSArray* ret = nil;
	NSArray* availColors = nil;
	
	TRACE_START();
	
	availColors = [[[NSArray alloc] initWithObjects: kStandardColor_Red, kStandardColor_Green,
						kStandardColor_Blue, kStandardColor_Cyan,
						kStandardColor_Yellow, kStandardColor_Magenta,
						kStandardColor_Orange, kStandardColor_Purple,
						kStandardColor_Brown, nil] autorelease];
	ret = availColors;
	TRACE_END();
	return ret;
}


@end
