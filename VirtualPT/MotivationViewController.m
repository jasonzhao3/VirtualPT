//
//  MotivationController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/3/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "MotivationViewController.h"
#import "LoginViewController.h"
#define BAR_BUTTON_SIZE 32


@interface MotivationViewController ()

@end

@implementation MotivationViewController

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
//    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"menu"];
    [self setCustomNavigationButton];
    [self updateProfileLabel];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - updateUI
- (void)updateProfileLabel
{
    PFUser *currUser = [PFUser currentUser];
    PFObject *profile = currUser[@"profile"];
    
    if ([profile isEqual:[NSNull null]]) {
        [self.createProfileButtonView setTitle:@"New Profile" forState:UIControlStateNormal];
        self.injuryLabel.text = @"Please add your profile by clicking \"Create Profile\"";
        self.goalLabel.text = @"";
        self.inspirationLabel.text = @"";
    } else {
        [self.createProfileButtonView setTitle:@"Edit Profile" forState:UIControlStateNormal];
        [profile fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            self.injuryLabel.text = profile[@"injury"];
        }];

    }

//    self.goalLabel.text = profile[@"goal"];

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

- (IBAction)showMenu:(id)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];

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


- (void)setCustomNavigationButton
{
    UIImage* img = [UIImage imageNamed:@"menu"];
    CGRect frameimg = CGRectMake(0, 0, BAR_BUTTON_SIZE, BAR_BUTTON_SIZE);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:img forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(backToMenueSegue)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem=backButton;
}




@end
