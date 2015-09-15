//
//  main.m
//  TestGraphy
//
//  Created by Craig McFarlane on 2/09/2015.
//  Copyright (c) 2015 Delaney & Morgan Computing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GraphyView.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [GraphyView class];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
