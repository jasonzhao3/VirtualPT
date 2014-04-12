//
//  VPTViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/2/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "VPTAppDelegate.h"

@interface LoginViewController ()
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *userId;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (nonatomic,strong)NSArray* fetchedUsersArray;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    VPTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    self.fetchedUsersArray = [appDelegate getUserList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:TRUE];
}


- (IBAction)login:(id)sender {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@", self.userId.text];
    NSArray *result = [self.fetchedUsersArray filteredArrayUsingPredicate:predicate];
    NSLog (@"finish query user id: %@", result);
    if (!result || !result.count || ![self validatePassword:(User *)[result objectAtIndex:0]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"User doesn't exist or password doesn't match!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } else {
        [self performSegueWithIdentifier:@"loginSegue" sender:nil];
    }
}

- (BOOL)validatePassword:(User *)result {
    NSString *password = result.password;
    if ([password isEqualToString:self.password.text])
        return true;
    else
        return false;
}

@end
