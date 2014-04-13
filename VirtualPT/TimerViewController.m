//
//  TimerViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/12/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "TimerViewController.h"
#import "LoginViewController.h"

@interface TimerViewController () {
    NSDate *pausedTime;
    BOOL isRunning;
    NSTimeInterval duration;
}
// Yang: is there a better way to define private variables??

@property (strong, nonatomic) NSTimer *countDownTimer;
@property (weak, nonatomic) IBOutlet UIButton *runButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@end

@implementation TimerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.timerLabel setHidden:YES];
    isRunning = false;
    duration = 0.0;
    self.timerPicker.countDownDuration = 300.0f;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)run:(id)sender {
    if ( !isRunning ) {
        duration = [self.timerPicker countDownDuration];
        [self updateDuration:duration];
        [self.timerLabel setHidden:NO];
        [self.timerPicker setHidden:YES];
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        [self.runButton setTitle:@"Cancel" forState:UIControlStateNormal];
    } else {
        [self.countDownTimer invalidate];
        [self.timerPicker setHidden:NO];
        [self.timerLabel setHidden:YES];
        [self.runButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    isRunning = !isRunning;
}



- (IBAction)pause:(id)sender {
    if (isRunning) {
        [self.countDownTimer invalidate];
        [self.pauseButton setTitle:@"Resume" forState:UIControlStateNormal];
    } else {
        [self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        
    }
    isRunning = !isRunning;
}


#pragma -- navigation 

- (IBAction)showMenu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)logout:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] init];
    
    [alert setTitle:@"Confirm"];
    [alert setMessage:@"Do you really want to logout?"];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // Yes, do something
        NSLog(@"clicked yes!");
        LoginViewController *lc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
        [self.navigationController pushViewController:lc animated:YES];
        
        //        [self.navigationController popViewControllerAnimated:YES];
        //        [self performSegueWithIdentifier:@"backLoginSegue" sender:nil];
    }
    else if (buttonIndex == 1)
    {
        // No
        NSLog(@"clicked no!");
    }
}


#pragma -- helper functions

- (void)timerFired:(NSTimer *)timer
{
    duration -= [timer timeInterval];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateDuration:duration];
        if (duration <= 0.0) {
            [self.countDownTimer invalidate];
            [self playFinishedSound];
        } else if ((uint32_t)duration % 60 == 0) {
            [self playIntervalSound];
        }
    });
}

- (void)updateDuration:(NSTimeInterval)interval
{
    uint32_t hours = (uint32_t)( duration / 3600.0 );
    uint32_t minutes = (uint32_t)( ( duration - hours * 3600.0 ) / 60 );
    uint32_t seconds = (uint32_t)( duration - hours * 3600.0 - minutes * 60.0 );
    self.timerLabel.text = [[NSString alloc] initWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

- (void)playFinishedSound
{
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

- (void)playIntervalSound
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
