//
//  ExerciseLibraryTVC.m
//  VirtualPT
//
//  Created by Jason Zhao on 5/13/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "ExerciseLibraryTVC.h"
#import "ExerciseInfoViewController.h"


@interface ExerciseLibraryTVC ()

@end

@implementation ExerciseLibraryTVC

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
  
    // Load data from CSV
    //    [self loadCSVData];
    //    self.exerciseList = [appDelegate getExerciseList];
    //    NSLog (@"exercseList from core data is: %@", self.exerciseList);

    
    //
    // Load data from Parse
    PFQuery *query = [PFQuery queryWithClassName:@"Exercise"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            //           [self storePFObjectToExercise: objects];
            self.exerciseList = objects;
            // reloadData has to be called inside background thread
            [self.tableView reloadData];
            //            NSLog (@"exerciseList is: %@", self.exerciseList);
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    //TODO: not sure whether this is the professional way to do this
    [self performSegueWithIdentifier:@"showExerciseSegue" sender:[tableView cellForRowAtIndexPath:indexPath]];
    //    NSLog(@"tapped button at row: %@",cell.nameLabel.text);
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ExerciseInfoViewController *infoVC = segue.destinationViewController;
    NSIndexPath *selectedPath = [self.tableView indexPathForCell:sender];

    // Core Data version
//    Exercise *currExercise = self.exerciseList[selectedPath.row];
//    
//    infoVC.reps = [@"Reps: " stringByAppendingString:[currExercise.reps stringValue]];
//    infoVC.hold = [@"Hold: " stringByAppendingString:[currExercise.hold stringValue]];
//    infoVC.duration = [@"Duration: " stringByAppendingString:[currExercise.hold stringValue]];
//    infoVC.imgURL = currExercise.imgURL;
//    infoVC.videoURL = currExercise.videoURL;
//    infoVC.instruction = currExercise.instruction;
    //    NSLog (@"original video URL is %@", currExercise.videoURL);
    
    // Parse version
    PFObject *currExercise = self.exerciseList[selectedPath.row];
    
    infoVC.reps = [@"Reps: " stringByAppendingString:[currExercise[@"reps"] stringValue]];
    infoVC.hold = [@"Hold: " stringByAppendingString:[currExercise[@"hold"] stringValue]];
    infoVC.duration = [@"Duration: " stringByAppendingString:[currExercise[@"hold"] stringValue]];
    infoVC.imgURL = currExercise[@"imgURL"];
    infoVC.videoURL = currExercise[@"videoURL"];
    infoVC.instruction = currExercise[@"instruction"];
}


@end
