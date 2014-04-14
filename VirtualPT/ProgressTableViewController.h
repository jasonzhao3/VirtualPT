//
//  ProgressTableViewController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/13/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface ProgressTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *progressList;
- (IBAction)showMenu:(id)sender;

@end
