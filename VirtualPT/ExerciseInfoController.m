//
//  VideoPlayerViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/13/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "ExerciseInfoViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ExerciseInfoViewController ()
@property (weak, nonatomic) IBOutlet UIView *videoPlayer;
@property (nonatomic, strong) MPMoviePlayerController *videoPlayerController;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *repsLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *holdLabel;
@property (weak, nonatomic) IBOutlet UITextView *instructionView;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *durationLabel;
@end

@implementation ExerciseInfoViewController

#pragma mark - view load
- (void)viewDidLoad
{
    [super viewDidLoad];
   //    // layout
//    {
//        self.view.backgroundColor = [UIColor darkGrayColor];
//        self.videoPlayer.frame = CGRectMake(80, 20, 180, 180);
//    }
    // prepare video /image
    [self prepareImageAndVideo];
    
    // update label
        {
            self.repsLabel.text = self.reps;
            self.holdLabel.text = [self.hold stringByAppendingString:@"s"];
            self.durationLabel.text = [self.duration stringByAppendingString:@"s"];
            self.instructionView.text = self.instruction;
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
        [self.videoPlayer addSubview:previewImageView];
        self.playButton.hidden = true;
    } else {
        // layout and size
        self.videoPlayerController.view.frame = self.videoPlayer.bounds;
        self.videoPlayerController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.videoPlayerController.controlStyle = MPMovieControlStyleNone;
        // add movie player to view
        [self.videoPlayer addSubview:self.videoPlayerController.view];
        // do not autostart
        [self.videoPlayerController prepareToPlay];
        self.videoPlayerController.shouldAutoplay = NO;
        
        // trying to repeat
        self.videoPlayerController.repeatMode = MPMovieRepeatModeOne;
    }

}

#pragma mark - user iteraction
- (IBAction)play:(id)sender {
    if (self.videoPlayerController.playbackState == MPMoviePlaybackStatePlaying) {
        [self.videoPlayerController pause];
        [self.playButton setTitle:@"Demo" forState:UIControlStateNormal];
//        NSLog(@"Pausing: %@", self.videoPlayerController.contentURL);
    }
    else {
        [self.videoPlayerController play ];
        [self.playButton setTitle:@"Pause" forState:UIControlStateNormal];
//        NSLog(@"Playing: %@", self.videoPlayerController.contentURL);
    }

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


#pragma mark - video player

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


//
//#pragma mark -- actionsheet
//- (IBAction)setReps:(id)sender {
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Face for Perform Dance step"
//                                                             delegate:self
//                                                    cancelButtonTitle:@"Cancel"
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:@"Camera", @"Select from Library", nil];
//    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
//    [actionSheet showInView:self.view];
//}
//
//#pragma mark - confirmation check
//- (IBAction)confirmCheck:(id)sender {
//    self.completeCount++;
//}



- (IBAction)changeLabel:(id)sender {
    
    [self.repsLabel setText:@"5"];
    self.holdLabel.text = self.hold;
    self.durationLabel.text = self.duration;
}
@end
