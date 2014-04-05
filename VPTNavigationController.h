//
//  VPTNavigationController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/3/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface VPTNavigationController : UINavigationController
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender;
@end
