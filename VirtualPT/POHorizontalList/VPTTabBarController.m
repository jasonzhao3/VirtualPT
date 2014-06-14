//
//  VPTTabBarController.m
//  VirtualPT
//
//  Created by Jason Zhao on 5/26/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "VPTTabBarController.h"

#define BAR_BUTTON_SIZE 32

@interface VPTTabBarController ()
@property (strong, nonatomic) PFUser *currUser;
@end

@implementation VPTTabBarController

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
    [self setCustomNavigationButton];
    self.currUser = [PFUser currentUser];
    [self loadProfile];
    NSLog(@"load VPT Tab bar");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - data manipulation
- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"View will disappear");
    self.currUser[@"motivation"] = self.motivation;
//    [self.motivation saveInBackground];
    [self.currUser saveInBackground];
    NSLog(@"%@", self.motivation);
}

- (void)loadProfile
{
    self.motivation = self.currUser[@"motivation"];
    NSLog(@"self.motivation is: %@", self.motivation);
    if ([self.motivation isEqual:[NSNull null]]) {
        self.motivation = [PFObject objectWithClassName:@"Motivation"];
        self.motivation[@"injury"] = [NSMutableDictionary dictionary];
        self.motivation[@"goal"] = [[NSMutableArray alloc] init];
        self.motivation[@"inspiration"] = [[NSMutableArray alloc] init];
        NSLog(@"create a new motivation");
    }
}


#pragma mark - tab bar delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    // Do Stuff!
//    if([item.title isEqualToString: @"Goal"]) {
//        NSLog(@"Come to goal!");
//    } else if ([item.title isEqualToString:@"Inspiration"]) {
//        NSLog(@"Come to Inspiration!");
//    } else {
//        NSLog(@"come to injury!");
//    }
}




# pragma mark - navigation
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

- (void)backSegue
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)backToMenueSegue
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
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

@end
