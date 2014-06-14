//
//  ExerciseTableViewController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/12/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import <Parse/Parse.h>
@interface ExerciseBaseTVC : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *exerciseList;
- (NSMutableArray *)parseScheduleExerciseList:(NSArray *)schedules;
@end
