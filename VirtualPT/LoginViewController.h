//
//  VPTViewController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/2/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate, LoginDelegate>
- (IBAction)login:(id)sender;
- (IBAction)fbLoginButton:(id)sender;
- (IBAction)twitterLoginButton:(id)sender;

@end
