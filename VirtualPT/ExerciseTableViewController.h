//
//  ExerciseTableViewController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/12/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
@interface ExerciseTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *exerciseList;

- (IBAction)showMenu:(id)sender;
@end
