//
//  DoExerciseViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/30/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "DoExerciseViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface DoExerciseViewController () {
    NSDate *pausedTime;
    BOOL isRunning;
    NSTimeInterval totalDuration;
    NSTimeInterval sectionDuration;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *visualView;
@property (weak, nonatomic) IBOutlet UILabel *sectionTimerLabel;
@property (weak, nonatomic) IBOutlet UIButton *pauseButtonView;

- (IBAction)pauseButton:(id)sender;
- (IBAction)exitButton:(id)sender;
- (IBAction)helpButton:(id)sender;


@property (strong, nonatomic) NSTimer *countDownTimer;
@property (nonatomic, strong) MPMoviePlayerController *videoPlayerController;

@end

@implementation DoExerciseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Update Title:
    {
        self.nameLabel.text = self.exerciseName;
    }
    
    // set up image / video view
    {
        [self prepareImageAndVideo];
    }
    
    // start timer
    {
        totalDuration = [self.duration doubleValue] * 5;
        sectionDuration = [self.duration doubleValue];
        [self updateDuration:totalDuration];
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        isRunning = true;
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - prepare video/image
- (void)prepareImageAndVideo
{
    if ([self.videoURL isEqualToString:@"null"]) {
        UIImageView *previewImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imgURL]];
        previewImageView.frame = CGRectMake(30, 10, 200, 180);
        [self.visualView addSubview:previewImageView];
        self.videoPlayerController = NULL;
    } else {
        // layout and size
        self.videoPlayerController.view.frame = self.visualView.bounds;
        self.videoPlayerController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.videoPlayerController.controlStyle = MPMovieControlStyleNone;
        // add movie player to view
        [self.visualView addSubview:self.videoPlayerController.view];
        // do autostart
        [self.videoPlayerController prepareToPlay];
        self.videoPlayerController.shouldAutoplay = YES;
        
        // trying to repeat
        self.videoPlayerController.repeatMode = MPMovieRepeatModeOne;
    }
}

- (MPMoviePlayerController *) videoPlayerController {
    if (!_videoPlayerController) {
        _videoPlayerController = [[MPMoviePlayerController alloc] init];
        [self prepareLocalMp4Movie:self.videoURL];
    }
    return _videoPlayerController;
}

- (void)prepareLocalMp4Movie:(NSString *) movie {
    // the URL already contains *.mp4, so here extension is empty
    NSURL *mp4MovieURL = [[NSBundle mainBundle] URLForResource:movie withExtension:@""];
    self.videoPlayerController.contentURL = mp4MovieURL;
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

- (IBAction)pauseButton:(id)sender {
    if (isRunning) {
        [self.countDownTimer invalidate];
        [self.pauseButtonView setTitle:@"RESUME" forState:UIControlStateNormal];
        if (self.videoPlayerController != NULL) {
            [self.videoPlayerController pause];
        }

    } else {
        [self.pauseButtonView setTitle:@"PAUSE" forState:UIControlStateNormal];
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        if (self.videoPlayerController != NULL) {
            [self.videoPlayerController play];
        }
    }
    isRunning = !isRunning;
}

- (IBAction)exitButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)helpButton:(id)sender {
}



#pragma -- helper functions

- (void)timerFired:(NSTimer *)timer
{
    totalDuration -= [timer timeInterval];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateDuration:totalDuration];
        if (totalDuration <= 0.0) {
            [self.countDownTimer invalidate];
            [self playFinishedSound];
        } else if ((uint32_t)totalDuration % 60 == 0) {
            [self playIntervalSound];
        }
    });
    
    sectionDuration -= [timer timeInterval];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateDuration:sectionDuration];
        if (sectionDuration <= 0.0) {
            [self.countDownTimer invalidate];
            [self playFinishedSound];
        } else if ((uint32_t)sectionDuration % 60 == 0) {
            [self playIntervalSound];
        }
    });
}

- (void)updateDuration:(NSTimeInterval)interval
{
    uint32_t hours = (uint32_t)( totalDuration / 3600.0 );
    uint32_t minutes = (uint32_t)( ( totalDuration - hours * 3600.0 ) / 60 );
    uint32_t seconds = (uint32_t)( totalDuration - hours * 3600.0 - minutes * 60.0 );
    self.totalTimeLabel.text = [[NSString alloc] initWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    
    minutes = (uint32_t)( ( sectionDuration - hours * 3600.0 ) / 60 );
    seconds = (uint32_t)( sectionDuration - hours * 3600.0 - minutes * 60.0 );
     self.sectionTimerLabel.text = [[NSString alloc] initWithFormat:@"%02d:%02d", minutes, seconds];
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
