//
//  MotivationController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/3/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "VPTBaseViewController.h"
#import <Parse/Parse.h>

@interface MotivationViewController : VPTBaseViewController
- (IBAction)showMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *injuryLabel;
@property (weak, nonatomic) IBOutlet UILabel *goalLabel;
@property (weak, nonatomic) IBOutlet UILabel *inspirationLabel;
@property (weak, nonatomic) IBOutlet UIButton *createProfileButtonView;

@end
