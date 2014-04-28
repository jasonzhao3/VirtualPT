//
//  InjuryController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/27/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "InjuryController.h"
#import <QuartzCore/QuartzCore.h>
#define NUM_JOINT 10


@interface InjuryController () {
    NSInteger tapCounts[NUM_JOINT];
}
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *bodyButtonView;

- (IBAction)bodyButtonAction:(id)sender;
@end

@implementation InjuryController
//@synthesize bodyButtonView = _bodyButtonView;

- (void)initTapCounts
{
    for (int i = 0; i < NUM_JOINT; i++) {
        tapCounts[i] = 0;
    }
}

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
    [self initTapCounts];
    // Do any additional setup after loading the view.
//    self.bodyButtonView.layer.cornerRadius = 15;
//    self.bodyButtonView.layer.borderWidth = 1;
//    self.bodyButtonView.layer.borderColor = [UIColor blueColor].CGColor;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)bodyButtonAction:(id)sender {
//    NSLog(@"Button pressed: %@", [sender currentTitle]);
    UIButton *theButton = (UIButton*)sender;
    
    int currIdx = [[sender currentTitle] intValue];
    if (tapCounts[currIdx] == 0)
    {
        tapCounts[currIdx]++;
        [theButton setImage:[UIImage imageNamed:@"yellow_button.png"] forState:UIControlStateNormal];
    }
    else if (tapCounts[currIdx] == 1)
    {
        tapCounts[currIdx]++;
        [theButton setImage:[UIImage imageNamed:@"red_button.png"] forState:UIControlStateNormal];
    } else {
        tapCounts[currIdx] = 0;
        [theButton setImage:[UIImage imageNamed:@"green_circle.png"] forState:UIControlStateNormal];
    }

}
- (IBAction)cancelProfile:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
