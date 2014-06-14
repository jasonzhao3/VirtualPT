//
//  InspirationController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/26/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoalController.h"
#import "VPTTabBarController.h"

@interface InspirationController : GoalController
@property (weak, nonatomic) IBOutlet UITableView *inspirationTableView;

- (IBAction)saveButton:(id)sender;
@end
