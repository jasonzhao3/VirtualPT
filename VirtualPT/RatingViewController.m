//
//  RatingViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/27/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "RatingViewController.h"
#import "VPTNavigationController.h"
#import "ProgressTableViewController.h"
#import <Parse/Parse.h>

#define CELL_HEIGHT 32
#define FIRST_FACE 1
#define SECOND_FACE 2
#define THIRD_FACE 3
#define FOURTH_FACE 4
#define FIFTH_FACE 5
#define SIXTH_FACE 6

@interface RatingViewController (){
    int selectedFaceIdx;
}
@property (strong,nonatomic) NSArray *phraseList;
@property (strong,nonatomic) NSArray *feedbackList;
@end


@implementation RatingViewController
@synthesize faceViews;

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
    selectedFaceIdx = -1;
    
    // set up tableview delegate
    self.evaluationTable.delegate = self;
    self.evaluationTable.dataSource = self;
    
    // Show one positive phrase at random
    self.phraseList = [NSArray arrayWithObjects: @"Amazing Job today, #name#!", @"Great work, #name#!", @"Awesome effort, #name#!", @"Go, #name# go!", @"#name#, Right on!", @"#name#, You crushed it today!", @"Congrats #name#! Job well accomplished!", @"#name#, You're on your way!", @"Love your hard work, #name#!", nil];
    
    self.feedbackList = [NSArray arrayWithObjects:@"Comfortable pace", @"It's alright",  @"Too much workload", nil];

    [self updatePositivePhrase];
    [self.evaluationTable reloadData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updatePositivePhrase
{
    NSInteger randomNumberInRange = arc4random() % [self.phraseList count];
    NSString *phrase = [self.phraseList objectAtIndex:randomNumberInRange];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#name#" options:NSRegularExpressionCaseInsensitive error:&error];
    PFUser *currUser = [PFUser currentUser];
    NSString *userName = currUser.username;
    NSLog(@"name is %@", [self capitalize:userName]);
    NSString *modifiedPhrase = [regex stringByReplacingMatchesInString:phrase options:0 range:NSMakeRange(0, [phrase length]) withTemplate:[self capitalize:userName]];
    self.positivePhrases.attributedText = [self SetLabelAttributes:modifiedPhrase size:20];
}

- (NSString *)capitalize:(NSString *)string
{
    NSLog(@"in string is %@", string);
    return [string stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[string substringToIndex:1] uppercaseString]];
}

- (NSMutableAttributedString *)SetLabelAttributes:(NSString *)input size:(Size)size {
    
    NSMutableAttributedString *labelAttributes = [[NSMutableAttributedString alloc] initWithString:input];
    
    UIFont *font=[UIFont fontWithName:@"GillSans-Bold" size:size];
    
    NSMutableParagraphStyle* style = [NSMutableParagraphStyle new];
    style.alignment = NSTextAlignmentCenter;
    
    [labelAttributes addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, labelAttributes.length)];
    [labelAttributes addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, labelAttributes.length)];
    [labelAttributes addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:101.0f/255.0f green:192.0f/255.0f blue:45.0f/255.0f alpha:1.0f] range:NSMakeRange(0, labelAttributes.length)];
    
    return labelAttributes;
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    NSLog(@"come into number of sections in tableview");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.feedbackList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"feedbackCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.textLabel.text = [self.feedbackList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Checked the selected row
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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

- (IBAction)clickRatingButton:(id)sender {
    // restore the original image
    int i = 1;
    for (UIButton *currButon in self.faceViews) {
            NSString *imageName = [NSString stringWithFormat:@"%@%@", [NSString stringWithFormat:@"%d",i], @" Face"];
            [currButon setBackgroundImage:[UIImage imageNamed: imageName] forState:UIControlStateNormal];
        ++i;
    }

    NSString *imageName =[NSString stringWithFormat:@"%@%@", [NSString stringWithFormat:@"%d",[sender tag]], @" Face_selected"];
    [sender setBackgroundImage:[UIImage imageNamed:imageName]forState:UIControlStateNormal];
    selectedFaceIdx = [sender tag];
}





- (IBAction)cancelButton:(id)sender {
    // directly back to the VC that are two hops away
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];

}


- (IBAction)doneButton:(id)sender {
    // TODO: store rating into database
    PFUser *currUser = [PFUser currentUser];
    PFObject *newRating = [PFObject objectWithClassName:@"Rating"];
    newRating[@"rating"] = [NSNumber numberWithInt:selectedFaceIdx];
    newRating[@"user"] = currUser;
    // by default, load today's data
    NSDate *date = [NSDate date];
    NSDate *today = [self dateAtBeginningOfDayForDate:date];
    newRating[@"date"] = today;
    [newRating saveInBackground];
    
    // directly back to the VC that are two hops away
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
}

- (NSDate *)dateAtBeginningOfDayForDate:(NSDate *)inputDate
{
    // Use the user's current calendar and time zone
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    // Selectively convert the date components (year, month, day) of the input date
    NSDateComponents *dateComps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:inputDate];
    
    // Set the time components manually
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    
    // Convert back
    NSDate *beginningOfDay = [calendar dateFromComponents:dateComps];
    return beginningOfDay;
}



@end
