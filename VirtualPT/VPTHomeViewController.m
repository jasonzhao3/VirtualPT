//
//  VPTHomeViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/3/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "VPTHomeViewController.h"
#import "LoginViewController.h"
@interface VPTHomeViewController ()

@end

@implementation VPTHomeViewController


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
