//
//  MotivationController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/3/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "PageController.h"
#import "LoginViewController.h"

@interface PageController ()

@end

@implementation PageController

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
    // Do any additional setup after loading the view.
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

- (IBAction)showMenu:(id)sender {
    // Dismiss keyboard (optional)
    //
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


@end
