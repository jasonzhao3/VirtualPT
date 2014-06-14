//
//  ExerciseTableViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/12/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//
/*
 --------
 DOUBLE KNEE TO CHEST STRETCH - DKTC
 While Lying on your back,  hold your knees and gently pull them up towards your chest.
 --------
 QUAD SET - TOWEL UNDER KNEE
  Place a small towel roll under your knee, tighten your top thigh muscle to press the back of your knee downward while pressing on the towel.
 -------
 HAMSTRING SET - MEDIAL BIAS
 While lying down on your back, slightly bend your knee with your leg rolled inward and then press your heel into the ground.
 ------
 KNEE FLEXION - SELF ASSISTED
 
 Lying on your back with knees straight, slide the affected heel towards your buttock as you bend your knee. Use the unaffected leg to assist the bending.
 
 Hold a gentle stretch in this position and then return to original position.
 
 -----
 SHORT ARC QUAD  - SAQ
 
 Place a rolled up towel or object under your knee and slowly straighten your knee as your raise up  your foot.
 
 */

#import "ExerciseBaseTVC.h"


#import "LoginViewController.h"
#import "CHCSVParser.h"
#import "VPTAppDelegate.h"
#import "Exercise.h"
#import "SimpleTableCell.h"
#import "User.h"

#define CELL_HEIGHT 72
#define THUMBNAIL_SIZE 66
#define CHECK_SIZE 18
#define BAR_BUTTON_SIZE 32

@interface ExerciseBaseTVC ()
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end

@implementation ExerciseBaseTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    // set up coredata delegate
    VPTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;

    // custom navigation bar
    [self setCustomNavigationButton];
    // custom table cell
    static NSString *CellIdentifier = @"exerciseCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"SimpleTableCell"  bundle:nil]  forCellReuseIdentifier:CellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - convert PFObject
- (void )storePFObjectToExercise: (NSArray *)objects
{
    [objects enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        // do something with object
        if (idx > 0) { // get rid of csv header
            Exercise * newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercise"
                                                                   inManagedObjectContext:self.managedObjectContext];
            // set up field
            newExercise.name = [object objectForKey:@"name"];
            newExercise.instruction = [object objectForKey:@"instruction"];
            
            newExercise.hold = [NSNumber numberWithInt:[[object objectForKey:@"hold"]integerValue]];
            newExercise.reps = [NSNumber numberWithInt:[[object objectForKey:@"reps"] integerValue]];
            newExercise.duration = [NSNumber numberWithInt:[[object objectForKey:@"duration"] integerValue]];
            newExercise.imgURL = [object objectForKey:@"imgURL"];
            newExercise.videoURL = [object objectForKey:@"videoURL"];
            
            //  save to database
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            } else {
                NSLog(@"save successfully: %@!", newExercise);
            }
        }
    }];

}

#pragma mark - initialize database with CSV

- (void)loadCSVData
{
    // Add Entry to PhoneBook Data base and reset all fields
    
    //TODO: validate existed account
    
    NSString *file = [[NSBundle bundleForClass:[self class]] pathForResource:@"hep2go" ofType:@"csv"];
	
	NSArray *contents = [NSArray arrayWithContentsOfCSVFile:file options:CHCSVParserOptionsRecognizesBackslashesAsEscapes];
//    NSLog (@"read %@", contents);
//
    [contents enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        // do something with object
        if (idx > 0) { // get rid of csv header
            Exercise * newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercise"
                                                                   inManagedObjectContext:self.managedObjectContext];
            // set up field
            newExercise.name = [object objectAtIndex:0];
            newExercise.instruction = [object objectAtIndex:1];
        
            newExercise.hold = [NSNumber numberWithInt:[[object objectAtIndex:2]integerValue]];
            newExercise.reps = [NSNumber numberWithInt:[[object objectAtIndex:3] integerValue]];
            newExercise.duration = [NSNumber numberWithInt:[[object objectAtIndex:4] integerValue]];
            newExercise.imgURL = [object objectAtIndex:5];
            newExercise.videoURL = [object objectAtIndex:6];
            
            //  save to database
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            } else {
                NSLog(@"save successfully: %@!", newExercise);
            }
      }
    }];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.exerciseList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"exerciseCell";
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
         cell = [[SimpleTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
/*
    // Configure the cell using core data exerciseList
    Exercise * exercise = [self.exerciseList objectAtIndex:indexPath.row];

    // make image size as a thumbnail
    cell.thumbnailImageView.frame = CGRectMake(12, 3, THUMBNAIL_SIZE, THUMBNAIL_SIZE);
    cell.thumbnailImageView.image = [UIImage imageNamed:exercise.imgURL];
    NSString *name = [exercise.name lowercaseString];
    cell.nameLabel.text = [name stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[name substringToIndex:1] uppercaseString]];
 */

    
    PFObject * exercise = [self.exerciseList objectAtIndex:indexPath.row];
//    NSLog (@"exercsise is %@", exercise);
    // make image size as a thumbnail
    cell.thumbnailImageView.frame = CGRectMake(12, 3, THUMBNAIL_SIZE, THUMBNAIL_SIZE);
    cell.thumbnailImageView.image = [UIImage imageNamed:[exercise objectForKey:@"imgURL"]];
    NSString *name = [[exercise objectForKey:@"name"] lowercaseString];
    cell.nameLabel.text = [name stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[name substringToIndex:1] uppercaseString]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Checked the selected row
    SimpleTableCell *cell = (SimpleTableCell *)[tableView cellForRowAtIndexPath:indexPath];
    Exercise *currExercise = self.exerciseList[indexPath.row];
    
    if (cell.isSelected == NO) {
        cell.checkImageView.frame = CGRectMake(60, 51, CHECK_SIZE, CHECK_SIZE);
        cell.checkImageView.image = [UIImage imageNamed:@"check"];
        cell.isSelected = YES;
        cell.nameLabel.textColor = [UIColor lightGrayColor];
        [self addExerciseToDatabase:currExercise];
    } else {
        cell.checkImageView.image = nil;
        cell.isSelected = NO;
        cell.nameLabel.textColor = [UIColor blackColor];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}



#pragma -mark database manipulation
- (void)addExerciseToDatabase:(Exercise *)exercise
{
    
    
}


//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}



//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - ParseHelper
- (NSMutableArray *)parseScheduleExerciseList:(NSArray *)schedules
{
    NSMutableArray *exercises = [[NSMutableArray alloc] initWithCapacity:schedules.count];
    for (PFObject *schedule in schedules)
    {
        [exercises addObject:schedule[@"exercise"]];
    }
    return exercises;
}

- (void)setCustomNavigationButton
{
    UIImage* img = [UIImage imageNamed:@"back"];
    CGRect frameimg = CGRectMake(0, 0, BAR_BUTTON_SIZE, BAR_BUTTON_SIZE);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:img forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(backSegue)
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



@end
