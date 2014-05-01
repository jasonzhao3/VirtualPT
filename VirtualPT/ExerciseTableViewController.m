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
 http://pdl.vimeocdn.com/00500/945/157799128.mp4?token2=1397365853_43a8e0cd6955389bbb4a66f7c39b5e4c&aksessionid=131b837b35e7b306
 
 -----
 SHORT ARC QUAD  - SAQ
 
 Place a rolled up towel or object under your knee and slowly straighten your knee as your raise up  your foot.
 
 */

#import "ExerciseTableViewController.h"
#import "ExerciseInfoViewController.h"

#import "LoginViewController.h"
#import "CHCSVParser.h"
#import "VPTAppDelegate.h"
#import "Exercise.h"
#import "SimpleTableCell.h"

#define CELL_HEIGHT 72
#define THUMBNAIL_SIZE 66
#define CHECK_SIZE 18
@interface ExerciseTableViewController ()
@property (strong) NSArray *array;
//@property (nonatomic,strong)NSArray* fetchedExercisesArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end

@implementation ExerciseTableViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:UITableViewCellStyleValue1];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    VPTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;

    // custom table cell
    static NSString *CellIdentifier = @"exerciseCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"SimpleTableCell"  bundle:nil]  forCellReuseIdentifier:CellIdentifier];

//    [self loadCSVData];
    self.exerciseList = [appDelegate getExerciseList];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - initialize database with CSV

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
//         NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
//        cell = [nib objectAtIndex:0];
//        NSLog (@"nil cell");
         cell = [[SimpleTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Exercise * exercise = [self.exerciseList objectAtIndex:indexPath.row];

    // make image size as a thumbnail
    cell.thumbnailImageView.frame = CGRectMake(12, 3, THUMBNAIL_SIZE, THUMBNAIL_SIZE);
    cell.thumbnailImageView.image = [UIImage imageNamed:exercise.imgURL];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",[exercise.name lowercaseString]];
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

    if (cell.isSelected == NO) {
        cell.checkImageView.frame = CGRectMake(60, 51, CHECK_SIZE, CHECK_SIZE);
        cell.checkImageView.image = [UIImage imageNamed:@"check"];
        cell.isSelected = YES;
    } else {
        cell.checkImageView.image = nil;
        cell.isSelected = NO;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    //TODO: not sure whether this is the professional way to do this
    [self performSegueWithIdentifier:@"showExerciseSegue" sender:[tableView cellForRowAtIndexPath:indexPath]];
//    NSLog(@"tapped button at row: %@",cell.nameLabel.text);
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


#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    self.title = @"Back";
//    NSLog(@"come to prepare for segue");

    ExerciseInfoViewController *infoVC = segue.destinationViewController;
    NSIndexPath *selectedPath = [self.tableView indexPathForCell:sender];
//    NSLog (@"selected exercise is %@", self.exerciseList[selectedPath.row]);
//    NSLog(@"select Path row is %ld", (long)selectedPath.row);
    Exercise *currExercise = self.exerciseList[selectedPath.row];
    NSLog(@"The current Exercise is %@", currExercise);
    infoVC.reps = [@"reps: " stringByAppendingString:[currExercise.reps stringValue]];
    infoVC.hold = [@"hold: " stringByAppendingString:[currExercise.hold stringValue]];
    infoVC.duration = [@"duration: " stringByAppendingString:[currExercise.hold stringValue]];
    infoVC.imgURL = currExercise.imgURL;
    infoVC.videoURL = currExercise.videoURL;
    infoVC.instruction = currExercise.instruction;
//    NSLog (@"original video URL is %@", currExercise.videoURL);
    
//    NSLog(@"reps is %@", infoVC.reps);
    
}

- (IBAction)showMenu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}


@end
