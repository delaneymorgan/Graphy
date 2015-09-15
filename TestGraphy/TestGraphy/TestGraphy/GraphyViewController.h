//
//  ViewController.h
//  TestGraphy
//
//  Created by Craig McFarlane on 2/09/2015.
//  Copyright (c) 2015 Delaney & Morgan Computing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphyView;

@interface GraphyViewController : UIViewController {
}
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet GraphyView* graph;
- (IBAction)graphPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *legendButton;


@end

