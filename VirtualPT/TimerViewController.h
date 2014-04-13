//
//  TimerViewController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/12/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioToolbox/AudioServices.h"
#import "PageController.h"

@interface TimerViewController : PageController
@property (weak, nonatomic) IBOutlet UIDatePicker *timerPicker;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

- (IBAction)run:(id)sender;
- (IBAction)pause:(id)sender;

//TODO: use button inheritance to deal with Menu and Logout buttons
- (IBAction)showMenu:(id)sender;
- (IBAction)logout:(id)sender;

@end
