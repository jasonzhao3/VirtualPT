//
//  VideoPlayerViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/13/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface VideoPlayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *videoPlayer;
@property (nonatomic, strong) MPMoviePlayerController *videoPlayerController;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic) int completeCount;
@end

@implementation VideoPlayerViewController
- (void)setCompleteCount:(int)completeCount
{
    _completeCount = completeCount;
    self.completeLabel.text = [NSString stringWithFormat:@"Completed: %d", self.completeCount];
}

#pragma mark - view load
- (void)viewDidLoad
{
    [super viewDidLoad];

//    // layout
//    {
//        self.view.backgroundColor = [UIColor darkGrayColor];
//        self.videoPlayer.frame = CGRectMake(80, 20, 180, 180);
//    }
    // video player
    {
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)nextVideo:(id)sender {
    
    NSString *videoPath = self.videoPlayerController.contentURL.description;
    NSRange rangeOfTitle = [videoPath rangeOfString:@"KneeFlextion"];
    if (rangeOfTitle.length) {
        [self prepareLocalMp4Movie:@"car"];
    }
    else {
        [self prepareLocalMp4Movie:@"short"];
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
        [self prepareLocalMp4Movie:@"KneeFlextion"];
    }
    return _videoPlayerController;
}

- (void)prepareLocalMp4Movie:(NSString *) movie {
    NSURL *mp4MovieURL = [[NSBundle mainBundle] URLForResource:movie withExtension:@"mp4"];
    self.videoPlayerController.contentURL = mp4MovieURL;
}



#pragma mark -- actionsheet
- (IBAction)setReps:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Face for Perform Dance step"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camera", @"Select from Library", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

#pragma mark - confirmation check
- (IBAction)confirmCheck:(id)sender {
    self.completeCount++;
}



@end
