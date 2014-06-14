//
//  MyExerciseTVC.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/30/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "VPTAppDelegate.h"
#import "MyExerciseTVC.h"
#import "SimpleTableCell.h"
#import "Exercise.h"
#import "DoExerciseViewController.h"

@interface MyExerciseTVC ()
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end

@implementation MyExerciseTVC

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
    
    // Load data from Parse for this particular user
    PFUser *currUser = [PFUser currentUser];
    PFQuery *scheduleQuery = [PFQuery queryWithClassName:@"Schedule"];
    [scheduleQuery includeKey:@"exercise"];
    [scheduleQuery whereKey:@"user" equalTo:currUser];
    [scheduleQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %d exercises.", objects.count);
            self.exerciseList = [self parseScheduleExerciseList:objects];
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimpleTableCell *cell = (SimpleTableCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"doExerciseSegue" sender:[tableView cellForRowAtIndexPath:indexPath]];

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DoExerciseViewController *doVC = segue.destinationViewController;
    NSIndexPath *selectedPath = [self.tableView indexPathForCell:sender];
    
//    Exercise *currExercise = self.exerciseList[selectedPath.row];
//    doVC.exerciseName = currExercise.name;
//    doVC.imgURL = currExercise.imgURL;
//    doVC.videoURL = currExercise.videoURL;
//    doVC.duration = currExercise.duration;
}

@end
