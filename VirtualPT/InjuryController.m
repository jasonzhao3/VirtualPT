//
//  InjuryController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/27/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "InjuryController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "FXBlurView.h"
#define NUM_JOINT 10


@interface InjuryController () {
    NSInteger tapCounts[NUM_JOINT];
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *bodyButtonView;
@property (weak, nonatomic) IBOutlet FXBlurView *welcomeView;
@property (weak, nonatomic) PFObject *motivation;

- (IBAction)bodyButtonAction:(id)sender;
@end

@implementation InjuryController
//@synthesize bodyButtonView = _bodyButtonView;

- (void)initTapCounts
{
    for (int i = 0; i < NUM_JOINT; i++) {
        tapCounts[i] = 0;
    }
}

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
    [self initTapCounts];
    self.welcomeView.alpha = 0.0;
    
    
    VPTTabBarController * tabBar = (VPTTabBarController *)[self tabBarController];
    self.motivation = tabBar.motivation;
    [self updateInjury];
    
//    self.navigationController.navigationBar.translucent = NO;

//    //configure blur view
//    self.welcomeView.dynamic = NO;
//    self.welcomeView.tintColor = [UIColor colorWithRed:0 green:0.5 blue:0.5 alpha:1];
//    self.welcomeView.contentMode = UIViewContentModeBottom;
//    
//    //take snapshot, then move off screen once complete
//    [self.welcomeView updateAsynchronously:YES completion:^{
//        self.welcomeView.frame = CGRectMake(0, 568, 320, 0);
//    }];
//    
//    if (YES) {
//        [UIView animateWithDuration:0.5 animations:^{
//            BOOL open = self.welcomeView.frame.size.height > 200;
//            self.welcomeView.frame = CGRectMake(0, open? 568: 143, 320, open? 0: 425);
//        }];
//    }
//
    
//    VPTTabBarController * tabBar = (VPTTabBarController *)[self tabBarController];
//    [tabBar setTitle:@"My Pain Map"];
    
    
    // Do any additional setup after loading the view.
//    self.bodyButtonView.layer.cornerRadius = 15;
//    self.bodyButtonView.layer.borderWidth = 1;
//    self.bodyButtonView.layer.borderColor = [UIColor blueColor].CGColor;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateInjury
{
    [self.motivation fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        //Again, be careful that we have to put everything in asynchrnous block
           NSDictionary *injuries = self.motivation[@"injury"];
//            NSLog(@"%@", injuries);
            for (NSString *key in injuries) {
//                NSLog(@"come to update injury!");
                UIButton *theButton = [self.bodyButtonView objectAtIndex:[key intValue]];
                NSString *imageName = nil;
                switch ([injuries[key] intValue]) {
                    case 1:
                        imageName = @"yellow_indicator.png";
                        break;
                    case 2:
                        imageName = @"red_indicator.png";
                        break;
                }
                [theButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                
            }

        }];
    
}


- (IBAction)bodyButtonAction:(id)sender {
//    NSLog(@"Button pressed: %@", [sender currentTitle]);
    UIButton *theButton = (UIButton*)sender;
    
    int currIdx = [[sender currentTitle] intValue];
    if (tapCounts[currIdx] == 0)
    {
        tapCounts[currIdx]++;
        [theButton setImage:[UIImage imageNamed:@"yellow_indicator.png"] forState:UIControlStateNormal];
    }
    else if (tapCounts[currIdx] == 1)
    {
        tapCounts[currIdx]++;
        [theButton setImage:[UIImage imageNamed:@"red_indicator.png"] forState:UIControlStateNormal];
    } else {
        tapCounts[currIdx] = 0;
        [theButton setImage:[UIImage imageNamed:@"green_indicator.png"] forState:UIControlStateNormal];
    }
    
    // update motivation, but not stored into Parse yet
    NSString *key = [sender currentTitle];
    NSMutableDictionary *injury = self.motivation[@"injury"];
    [injury setValue:[NSNumber numberWithInt:tapCounts[currIdx]] forKey:key];
    self.motivation[@"injury"] = injury;
    NSLog(@"%@", self.motivation);
}


/*
 // old navigation code
 
- (IBAction)cancelProfile:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextButton:(id)sender {
    // No need to check whether the user has a profile or not
    // everytime just fetch profile pointer, and update the profile
    PFUser *currUser = [PFUser currentUser];
    PFObject *profile = currUser[@"profile"];
    NSLog(@"%@", profile);
    NSLog(@"%@", currUser[@"somethingnew"]);
    
    if ([currUser[@"profile"] isEqual:[NSNull null]]) {
        NSLog(@"Now create a new profile");
        profile = [PFObject objectWithClassName:@"Profile"];
    } else {
        NSLog(@"profile already existed! Now update!");
    }
    
//    [profile fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//        profile[@"injury"] = [self combineInjuryString];
//    }];

    profile[@"injury"] = [self combineInjuryString];
    currUser[@"profile"] = profile;
    [currUser saveInBackground];
    

    [self performSegueWithIdentifier:@"injurySegue" sender:self];
}


- (NSString *)combineInjuryString
{
    return @"Right shoulder; Left Knee";
}
 */




@end
