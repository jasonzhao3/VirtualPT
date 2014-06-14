//
//  VPTNavigationController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/3/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "VPTNavigationController.h"
#import <Parse/Parse.h>
@interface VPTNavigationController ()
@end


@implementation VPTNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"load Navigation Controller!");
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // add swipe gesture to enable side Menu
//        NSLog (@"User already logged in!");
        [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];

    } else {
//        NSLog (@"User hasn't logged in yet!");
        // Do not add swipe gesture
    }

    }

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}

@end
