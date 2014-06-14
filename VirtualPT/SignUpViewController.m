//
//  SignUpViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/3/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "SignUpViewController.h"
#import "VPTAppDelegate.h"
#import "user.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *createBtn;

@property (weak, nonatomic) IBOutlet UITextField *userId;
@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *pwdConfirmation;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation SignUpViewController
@synthesize loginDelegate;


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
    [super viewDidLoad];// Do any additional setup after loading the view.

    // set delegate for core data
    VPTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;

    // set delegate for Login
    NSLog(@"self loginDelegate is %@", self.loginDelegate);
    
    // set delegate for form validation
    [self.userId setDelegate:self];
    [self.userName setDelegate:self];
    [self.email setDelegate:self];
    [self.password setDelegate:self];
    [self.pwdConfirmation setDelegate:self];

//    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (IBAction)cancelSignUp:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addProfile:(id)sender {
   [self performSegueWithIdentifier:@"createSegue" sender:nil];
}

- (IBAction)createUser:(id)sender {
    // Add Entry to PhoneBook Data base and reset all fields
    if (![self validateFields]) {
        return;
    }
    
    //TODO: validate existed account
    User * newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                   inManagedObjectContext:self.managedObjectContext];
    // set up each field
    newUser.userId = self.userId.text;
    newUser.userName = self.userName.text;
    newUser.email = self.email.text;
    newUser.password = self.password.text;
    newUser.timestamp = [NSDate date];
    
    //  save to database
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    } else {
//        NSLog(@"save successfully: %@!", newUser);
    }
    
    
    // save to Parse server
    PFUser *user = [PFUser user];
    user.username = self.userName.text;
    user.password = self.password.text;
    user.email = self.email.text;
    // has to initialize pointer type to [NSNull null]
    user[@"motivation"] = [NSNull null];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // should put log-in into this success block -- they're asynrounous!!
            // delegate back
            if([self.loginDelegate respondsToSelector:@selector(signUpViewControllerDismissed:password:)])
            {
                NSLog(@"Start delegation");
                [self.loginDelegate signUpViewControllerDismissed:self.userName.text password:self.password.text];
            }
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            NSLog (@"%@", errorString);
        }
    }];
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark - textField delegation
// Hide keyboard when done editing
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

// function to remove keyboard when tapping anywhere else on the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:TRUE];
}

// delegate method for form textField validation
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.email) {
        NSLog(@"come to validate email");
        if (![self validateEmail : textField.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a valid email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    } else if (textField == self.pwdConfirmation) {
        if (![textField.text isEqualToString: self.password.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Passwords don't match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

// email address validation helper function
- (BOOL)validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; //  return 0;
    return [emailTest evaluateWithObject:candidate];
}

- (BOOL)validateFields {
    if ([self.userId.text length] == 0 || [self.userName.text length] == 0 || [self.email.text length] == 0 || [self.password.text length] == 0 || [self.pwdConfirmation.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error: Empty field exists!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return false;
    }
    return true;
}


@end
