//
//  UtilitiesController.m
//  VirtualPT
//
//  Created by Jason Zhao on 5/8/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "UtilitiesController.h"

@interface UtilitiesController ()

@end

@implementation UtilitiesController

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

- (void)setCustomNavigationButton
{
    UIImage* img = [UIImage imageNamed:@"menu"];
    CGRect frameimg = CGRectMake(0, 0, BAR_BUTTON_SIZE, BAR_BUTTON_SIZE);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:img forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(backToMenueSegue)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem=backButton;
}

@end
