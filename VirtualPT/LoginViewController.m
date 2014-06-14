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
#import "VPTNavigationController.h"

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
    NSLog(@"load LoginView Controller!");
	// Do any additional setup after loading the view, typically from a nib.
    VPTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    self.fetchedUsersArray = [appDelegate getUserList];

    // set delegate to make sure keyboard hide when done editing
    [self.userId setDelegate:self];
    [self.password setDelegate:self];
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        NSLog (@"User already logged in!");
        [self performSegueWithIdentifier:@"loginSegue" sender:nil];
    } else {
        // show the signup or login screen
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -- hide keyboard

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:TRUE];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)login:(id)sender {
    /* 
     // Login validation using core data -- TODO: sync with Parse
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@", self.userId.text];
    NSArray *result = [self.fetchedUsersArray filteredArrayUsingPredicate:predicate];
   NSLog (@"finish query user id: %@", result);
    if (!result || !result.count || ![self validatePassword:(User *)[result objectAtIndex:0]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"User doesn't exist or password doesn't match!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    } else {
        [self performSegueWithIdentifier:@"loginSegue" sender:nil];
    }
     */
    
    // Login validation using Parse  -- TODO: offline core data mode
    
    [PFUser logInWithUsernameInBackground:self.userId.text password:self.password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            NSLog (@"Successfully log in!");
                                            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
                                            [self enableMenuSwipe];
                                        } else {
                                            // The login failed. Check error to see why.
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"User doesn't exist or password doesn't match!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                            [alert show];
                                        }
                                    }];
}

- (BOOL)validatePassword:(User *)result {
    NSString *password = result.password;
    if ([password isEqualToString:self.password.text])
        return true;
    else
        return false;
}

# pragma mark - signup delegate
-(void) signUpViewControllerDismissed:(NSString *)username password:(NSString *)password
{
//    NSLog(@"Come to the delegation");
    [PFUser logInWithUsernameInBackground:username password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            NSLog (@"Successfully log in!");
                                            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
                                            [self enableMenuSwipe];
                                        } else {
                                            // The login failed. Check error to see why.
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"User doesn't exist or password doesn't match!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                            [alert show];
                                        }
  }];
}



#pragma mark - swipe menu
- (void)enableMenuSwipe
{
//    NSLog(@"come to enable menu swipe!");
    [self.navigationController.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController action:@selector(panGestureRecognized:)]];
//    VPTNavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"rootNavigationController"];
//    [navigationController.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

#pragma mark - facebook login


- (IBAction)fbLoginButton:(id)sender {
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    __block PFUser *currUser;
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
//        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            currUser = user;
            // mannually initialize profile pointer
            user[@"profile"] = [NSNull null];
            [user saveInBackground];
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        } else {
            NSLog(@"User with facebook logged in!");
            currUser = user;
            [self enableMenuSwipe];
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
    
    
    if (![PFFacebookUtils isLinkedWithUser:currUser]) {
        [PFFacebookUtils linkUser:currUser permissions:nil block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Woohoo, user logged in with Facebook!");
            }
        }];
    }
    

}

- (IBAction)twitterLoginButton:(id)sender {
    NSLog(@"ready to sign up with twitter");
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in with Twitter!");
        } else {
            NSLog(@"User logged in with Twitter!");
        }     
    }];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"signUpSegue"]) {
        SignUpViewController *signUpVC = segue.destinationViewController;
        signUpVC.loginDelegate = self;
    }
}
@end
