//
//  VPTTabBarController.h
//  VirtualPT
//
//  Created by Jason Zhao on 5/26/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "REFrostedViewController.h"

@interface VPTTabBarController : UITabBarController
@property (strong, nonatomic) PFObject *motivation;
@end
