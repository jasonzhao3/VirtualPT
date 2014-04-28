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
#import "VPTAppDelegate.h"
#import "user.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet FUIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet FUIButton *createBtn;
@property (weak, nonatomic) IBOutlet UITextField *userId;
@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *pwdConfirmation;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

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
    [super viewDidLoad];// Do any additional setup after loading the view.
    VPTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;

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
        NSLog(@"save successfully: %@!", newUser);
    }
    
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
