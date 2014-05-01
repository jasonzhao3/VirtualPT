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
//    // Do any additional setup after loading the view.
//    VPTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    self.managedObjectContext = appDelegate.managedObjectContext;
//
//    // custom table cell
//    static NSString *CellIdentifier = @"exerciseCell";
//    [self.tableView registerNib:[UINib nibWithNibName:@"SimpleTableCell"  bundle:nil]  forCellReuseIdentifier:CellIdentifier];
//    
//    
//    self.exerciseList = [appDelegate getExerciseList];
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Checked the selected row
//    SimpleTableCell *cell = (SimpleTableCell *)[tableView cellForRowAtIndexPath:indexPath];
//    Exercise *currExercise = self.exerciseList[indexPath.row];
////    
//    if (cell.isSelected == NO) {
//        cell.checkImageView.frame = CGRectMake(60, 51, CHECK_SIZE, CHECK_SIZE);
//        cell.checkImageView.image = [UIImage imageNamed:@"check"];
//        cell.isSelected = YES;
//        cell.nameLabel.textColor = [UIColor lightGrayColor];
//        [self addExerciseToDatabase:currExercise];
//    } else {
//        cell.checkImageView.image = nil;
//        cell.isSelected = NO;
//        cell.nameLabel.textColor = [UIColor blackColor];
//    }
    [self performSegueWithIdentifier:@"doExerciseSegue" sender:[tableView cellForRowAtIndexPath:indexPath]];

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DoExerciseViewController *doVC = segue.destinationViewController;
    NSIndexPath *selectedPath = [self.tableView indexPathForCell:sender];
    
    Exercise *currExercise = self.exerciseList[selectedPath.row];
    doVC.exerciseName = currExercise.name;
    doVC.imgURL = currExercise.imgURL;
    doVC.videoURL = currExercise.videoURL;
    doVC.duration = currExercise.duration;
}

@end
