//
//  DoExerciseViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/30/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "DoExerciseViewController.h"
#import <MediaPlayer/MediaPlayer.h>


#define alertViewNext 0
#define alertViewDone 1

@interface DoExerciseViewController () {
    NSDate *pausedTime;
    BOOL isRunning;
    NSTimeInterval totalDuration;
    NSTimeInterval sectionDuration;
    int currExerciseIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *visualView;
@property (weak, nonatomic) IBOutlet UILabel *sectionTimerLabel;
@property (weak, nonatomic) IBOutlet UIButton *pauseButtonView;

- (IBAction)pauseButton:(id)sender;
- (IBAction)exitButton:(id)sender;



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
    currExerciseIndex = 0;
    PFObject *firstExercise = [self.exerciseList objectAtIndex:0];
    // Update Title:
    {
        self.nameLabel.text = firstExercise[@"name"];
    }
    
    // set up image / video view
    {
        [self prepareImageAndVideo:firstExercise[@"videoURL"] imgURL:firstExercise[@"imgURL"]];
    }
    
    // start timer
    {
        totalDuration = [self getTotalDuration];
        sectionDuration = [firstExercise[@"duration"] floatValue];
//        [self updateDuration:totalDuration];
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
- (void)prepareImageAndVideo:(NSString *)videoURL imgURL:(NSString *)imgURL
{
    if ([videoURL isEqualToString:@"null"]) {
        UIImageView *previewImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgURL]];        
        previewImageView.frame = CGRectMake(0, 0, self.visualView.frame.size.width, self.visualView.frame.size.height);
        [self.visualView addSubview:previewImageView];
        self.videoPlayerController = NULL;
    } else {
        // layout and size
//        NSLog(@"video URL is %@", videoURL);
        self.videoPlayerController.view.frame = self.visualView.bounds;
        self.videoPlayerController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.videoPlayerController.controlStyle = MPMovieControlStyleNone;
        // add movie player to view
        [self.visualView addSubview:self.videoPlayerController.view];
        
        // load video file
        [self prepareLocalMp4Movie:videoURL];
        // do autostart
        [self.videoPlayerController prepareToPlay];
        self.videoPlayerController.shouldAutoplay = YES;
        
        // trying to repeat
        self.videoPlayerController.repeatMode = MPMovieRepeatModeOne;
    }
}

// This setter is very essential!!
- (MPMoviePlayerController *) videoPlayerController {
    if (!_videoPlayerController) {
        _videoPlayerController = [[MPMoviePlayerController alloc] init];
    }
    return _videoPlayerController;
}

- (void)prepareLocalMp4Movie:(NSString *) movie {
    // the URL already contains *.mp4, so here extension is empty
    NSURL *mp4MovieURL = [[NSBundle mainBundle] URLForResource:movie withExtension:@""];
    self.videoPlayerController.contentURL = mp4MovieURL;
}



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
    [self.countDownTimer invalidate];
    //TODO: store the time completed into database
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - parse exercise
- (NSNumber *)convertStringToNSNumber:(NSString *)numberString
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *number = [f numberFromString:numberString];
    return number;
}

- (float) getTotalDuration
{
    float sum = 0.0;
    for (PFObject *exercise in self.exerciseList)
    {
        sum += [exercise[@"duration"] floatValue];
    }
    return sum;
}


- (void) loadExerciseInfo:(PFObject *)exercise
{
    // Update Title:
    {
        self.nameLabel.text = exercise[@"name"];
    }
    
    // set up image / video view
    {
        [self prepareImageAndVideo:exercise[@"videoURL"] imgURL:exercise[@"imgURL"]];
    }
    
    // start timer
    {
        sectionDuration = [exercise[@"duration"] floatValue];
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        isRunning = true;
    }

}
#pragma mark - timer

- (void)timerFired:(NSTimer *)timer
{
    totalDuration -= [timer timeInterval];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateDuration:totalDuration];
        if (totalDuration <= 0.0) {
            [self.countDownTimer invalidate];
            [self playFinishedSound];
            
            UIAlertView *alert = [[UIAlertView alloc] init];
            
            [alert setTitle:@"Congratulations!"];
            [alert setMessage:@"Awesome Job! You have finished today's exercise. Would you like to take a brief evaluation?"];
            [alert setDelegate:self];
            [alert addButtonWithTitle:@"Yes"];
            [alert addButtonWithTitle:@"No"];
            [alert setTag:alertViewDone];
            [alert show];
            
        } else if ((uint32_t)totalDuration % 60 == 0) {
            [self playIntervalSound];
        }
    });
    
    sectionDuration -= [timer timeInterval];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateDuration:sectionDuration];
        if (sectionDuration <= 0.0 && totalDuration > 0.0) {
            [self.countDownTimer invalidate];
            if (self.videoPlayerController != NULL) {
                [self.videoPlayerController stop];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!"
                                                            message:@"Awesome Job! You have just finished one exercise. Ready to go to the next exercise?"
                                                           delegate:self
                                                  cancelButtonTitle:@"Go!"
                                                  otherButtonTitles:nil];
            alert.tag = alertViewNext;
            [alert show];
           
        } else if ((uint32_t)sectionDuration % 60 == 0) {
            [self playIntervalSound];
        }
    });
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == alertViewNext)
    {
        // load next exercise and reset section timer
        ++currExerciseIndex;
        [self loadExerciseInfo:[self.exerciseList objectAtIndex:currExerciseIndex]];
    } else {
        if (buttonIndex == 0)
        {
            // Yes, do something
            [self performSegueWithIdentifier:@"goEvaluationSegue" sender:nil];
        }
        else if (buttonIndex == 1)
        {
            // No
            [self dismissViewControllerAnimated:YES completion:nil];
        }

    }
    
}


- (void)updateDuration:(NSTimeInterval)interval
{
    uint32_t hours = (uint32_t)( totalDuration / 3600.0 );
    uint32_t minutes = (uint32_t)( ( totalDuration - hours * 3600.0 ) / 60 );
    uint32_t seconds = (uint32_t)( totalDuration - hours * 3600.0 - minutes * 60.0 );
    NSString *timeStr = [[NSString alloc] initWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    self.totalTimeLabel.attributedText = [self SetLabelAttributes:timeStr size:32];

    
    minutes = (uint32_t)( ( sectionDuration - hours * 3600.0 ) / 60 );
    seconds = (uint32_t)( sectionDuration - hours * 3600.0 - minutes * 60.0 );
    
    timeStr = [[NSString alloc] initWithFormat:@"%02d:%02d", minutes, seconds];
     self.sectionTimerLabel.attributedText = [self SetLabelAttributes:timeStr size:17];
}


- (NSMutableAttributedString *)SetLabelAttributes:(NSString *)input size:(Size)size {
    
    NSMutableAttributedString *labelAttributes = [[NSMutableAttributedString alloc] initWithString:input];
    
    UIFont *font=[UIFont fontWithName:@"GillSans-Bold" size:size];
    
    NSMutableParagraphStyle* style = [NSMutableParagraphStyle new];
    style.alignment = NSTextAlignmentCenter;
    
    [labelAttributes addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, labelAttributes.length)];
    [labelAttributes addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, labelAttributes.length)];
    [labelAttributes addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, labelAttributes.length)];
    
    return labelAttributes;
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
