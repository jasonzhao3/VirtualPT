//
//  TodayExerciseTVC.h
//  VirtualPT
//
//  Created by Jason Zhao on 5/13/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "VPTBaseViewController.h"
@interface TodayExerciseVC : VPTBaseViewController<UITableViewDelegate, UITableViewDataSource>{
    NSDate *today;
    NSDate *currDate;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgPreview;
@property (weak, nonatomic) IBOutlet UITableView *exerciseTableView;
@property (weak, nonatomic) IBOutlet UIButton *previewButtonView;
@property (strong, nonatomic) NSArray *exerciseList;



- (IBAction)yesterdayButton:(id)sender;
- (IBAction)todayButton:(id)sender;
- (IBAction)tomorrowButton:(id)sender;
- (IBAction)startButton:(id)sender;


@end
