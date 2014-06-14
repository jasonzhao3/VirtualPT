//
//  VideoPlayerViewController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/13/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPTBaseViewController.h"
@interface ExerciseInfoViewController : VPTBaseViewController
@property(strong, nonatomic) NSString *reps;
@property(strong, nonatomic) NSString *hold;
@property(strong, nonatomic) NSString *duration;
@property(strong, nonatomic) NSString *imgURL;
@property(strong, nonatomic) NSString *videoURL;
@property(strong, nonatomic) NSString *instruction;
@end
