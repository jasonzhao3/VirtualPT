//
//  SignUpViewController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/3/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPTNavigationController.h"
#import "LoginViewController.h"

@interface SignUpViewController : UIViewController<UITextFieldDelegate>
- (IBAction)cancelSignUp:(id)sender;
- (IBAction)addProfile:(id)sender;
- (IBAction)createUser:(id)sender;


@end
