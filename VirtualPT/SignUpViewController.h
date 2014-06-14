//
//  SignUpViewController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/3/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPTNavigationController.h"

@protocol LoginDelegate <NSObject>
-(void) signUpViewControllerDismissed:(NSString *)username password:(NSString *)password;
@end


@interface SignUpViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, assign) id <LoginDelegate> loginDelegate;
- (IBAction)cancelSignUp:(id)sender;
- (IBAction)addProfile:(id)sender;
- (IBAction)createUser:(id)sender;


@end
