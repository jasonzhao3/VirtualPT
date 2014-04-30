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
#import "LoginViewController.h"
#import "VideoPlayerViewController.h"
#import "CHCSVParser.h"
#import "VPTAppDelegate.h"
#import "Exercise.h"


@interface ExerciseTableViewController ()
@property (strong) NSArray *array;
//@property (nonatomic,strong)NSArray* fetchedExercisesArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end

@implementation ExerciseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    VPTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    
//    self.exerciseList = [NSArray arrayWithObjects:@"Knee Flextion", @"Double Knee To Chest Stretch", @"Short Arc Quad", @"Quad Set", @"Hamstring Set", nil];
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
    NSLog (@"read %@", contents);
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
            newExercise.imgURL = [object objectAtIndex:4];
            newExercise.videoURL = [object objectAtIndex:5];
            
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        NSLog (@"nil cell");
    }
    
    // Configure the cell...
//    NSLog (@"The cell content is %@", [self.exerciseList objectAtIndex:indexPath.row]);
    Exercise * exercise = [self.exerciseList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[exercise.name lowercaseString]];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


//- (void)prepareVideoViewController:(VideoPlayerViewController *)ivc toDisplayVideo:(NSDictionary *)videoJson
//{
//    ivc.videoURL = [FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatLarge];
//    ivc.title = [photo valueForKeyPath:FLICKR_PHOTO_TITLE];
//}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.title = @"Back";
    
//    if ([sender isKindOfClass:[UITableViewCell class]]) {
//        // find out which row in which section we're seguing from
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//        if (indexPath) {
//            // found it ... are we doing the Display Photo segue?
//            if ([segue.identifier isEqualToString:@"showExerciseSegue"]) {
//                // yes ... is the destination an ImageViewController?
//                if ([segue.destinationViewController isKindOfClass:[VideoPlayerViewController class]]) {
//                    // yes ... then we know how to prepare for that segue!
//                    [self prepareVideoViewController:segue.destinationViewController
//                                      toDisplayPhoto:self.photos[indexPath.row]];
//                }
//            }
//        }
//    }

    
}


- (IBAction)showMenu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];

    [self.frostedViewController presentMenuViewController];

}


@end
