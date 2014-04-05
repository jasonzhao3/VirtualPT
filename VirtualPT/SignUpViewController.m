//
//  SignUpViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/3/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "SignUpViewController.h"
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet FUIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet FUIButton *createBtn;

@end

@implementation SignUpViewController

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
//    self.cancelBtn.buttonColor = [UIColor cloudsColor];
//    self.cancelBtn.cornerRadius = 6.0f;
    // Do any additional setup after loading the view.
//    [self updateUI];
}

- (void)updateUI
{
    self.cancelBtn.buttonColor = [UIColor cloudsColor];
    self.cancelBtn.cornerRadius = 6.0f;

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

- (IBAction)cancelSignUp:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    VPTNavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
//    
//    VPTViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginController"];
//    
//    navigationController.viewControllers = @[loginViewController];
//    
//    self.frostedViewController.contentViewController = navigationController;
//    [self.frostedViewController hideMenuViewController];
}
@end
