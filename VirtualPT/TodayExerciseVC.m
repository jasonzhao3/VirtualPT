//
//  TodayExerciseTVC.m
//  VirtualPT
//
//  Created by Jason Zhao on 5/13/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "TodayExerciseVC.h"
#import "SimpleTableCell.h"
#import "DoExerciseViewController.h"

#define CELL_HEIGHT 72
#define THUMBNAIL_SIZE 66
#define CHECK_SIZE 18
#define PREVIEW_SIZE 72


@interface TodayExerciseVC ()
@property (weak, nonatomic) IBOutlet UITextView *previewTextView;

@end

@implementation TodayExerciseVC
@synthesize exerciseTableView;

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
    
    // custom table cell
    static NSString *CellIdentifier = @"exerciseCell";
    [self.exerciseTableView registerNib:[UINib nibWithNibName:@"SimpleTableCell"  bundle:nil]  forCellReuseIdentifier:CellIdentifier];
    
    // set tableView's delegate
    [self.exerciseTableView setDataSource:self];
    [self.exerciseTableView setDelegate:self];

    // set up the image preview frame
     self.imgPreview.frame = CGRectMake(12, 3, PREVIEW_SIZE, PREVIEW_SIZE);
    
    // by default, load today's data
    NSDate *date = [NSDate date];
    today = [self dateAtBeginningOfDayForDate:date];
    currDate = today;
    [self loadExerciseForDate:today];
    
    // set navigation bar title
    self.title = [self dateToString:today];


   
}

- (void)loadExerciseForDate:(NSDate *)date
{
    // Load data from Parse for this particular user
    PFUser *currUser = [PFUser currentUser];

    PFQuery *scheduleQuery = [PFQuery queryWithClassName:@"Schedule"];
    [scheduleQuery includeKey:@"exercise"];
    [scheduleQuery whereKey:@"user" equalTo:currUser];
    [scheduleQuery whereKey:@"date" equalTo:date];
    [scheduleQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
//            NSLog(@"Successfully retrieved %d exercises.", objects.count);
            self.exerciseList = [self parseScheduleExerciseList:objects];
            [self.exerciseTableView reloadData];
            [self setUpPreviewInfo:self.exerciseList];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


- (void)setUpPreviewInfo:(NSArray *)exercistList
{
    if ([exercistList count] > 0)
    {
        PFObject *firstExercise = [self.exerciseList objectAtIndex:0];
        self.imgPreview.image = [UIImage imageNamed:[firstExercise objectForKey:@"imgURL"]];
        self.previewButtonView.hidden = NO;
        self.previewTextView.text = @"Hi there,\n I'm your personal PT. Let's get started! 😄";
    } else
    {
        self.imgPreview.image = [UIImage imageNamed:@"oops"];
        self.previewButtonView.hidden = YES;
        self.previewTextView.text = @"Oops! \nNo exercise scheduled yet. Please have your therapist update your exercise plan via our online portal";
    }
//    UIImage *playImage = [UIImage imageNamed:@"play-button"];
//    [self.previewButtonView setBackgroundImage:playImage forState:UIControlStateNormal];
}

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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"come into number of sections in tableview");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.exerciseList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"exerciseCell";
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if (cell == nil) {
        cell = [[SimpleTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
    PFObject * exercise = [self.exerciseList objectAtIndex:indexPath.row];
    
    // make image size as a thumbnail
    cell.thumbnailImageView.frame = CGRectMake(12, 3, THUMBNAIL_SIZE, THUMBNAIL_SIZE);
    cell.thumbnailImageView.image = [UIImage imageNamed:[exercise objectForKey:@"imgURL"]];
    NSString *name = [[exercise objectForKey:@"name"] lowercaseString];
    cell.nameLabel.text = [name stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[name substringToIndex:1] uppercaseString]];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DoExerciseViewController *doVC = segue.destinationViewController;
    doVC.exerciseList = self.exerciseList;
}


- (IBAction)yesterdayButton:(id)sender {
    NSDate *yesterday = [self getPreviousDate];
    currDate = yesterday;
    self.navigationItem.title = [self dateToString:currDate];
    [self loadExerciseForDate:yesterday];
}

- (IBAction)todayButton:(id)sender {
    currDate = today;
    self.navigationItem.title = [self dateToString:currDate];
    [self loadExerciseForDate:today];
}

- (IBAction)tomorrowButton:(id)sender {
    NSDate *tomorrow = [self getNextDate];
    currDate = tomorrow;
    self.navigationItem.title = [self dateToString:currDate];
    [self loadExerciseForDate:tomorrow];
}

- (IBAction)startButton:(id)sender {
    [self performSegueWithIdentifier:@"startPTSegue" sender:nil];
}




#pragma mark - date helper
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

- (NSDate *)getNextDate
{
   NSDate *tomorrow = [NSDate dateWithTimeInterval:(24*60*60) sinceDate:currDate];
   return tomorrow;
}

- (NSDate *)getPreviousDate
{
    NSDate *date = [NSDate dateWithTimeInterval:(-24*60*60) sinceDate:currDate];
    return date;
}

- (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM/dd/yyyy"];
    NSString *result = [df stringFromDate:date];
    return result;
}


@end
