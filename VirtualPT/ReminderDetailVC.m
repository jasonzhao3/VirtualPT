//
//  ReminderDetailVC.m
//  VirtualPT
//
//  Created by Jason Zhao on 5/27/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "ReminderDetailVC.h"

@interface ReminderDetailVC ()
@property (weak, nonatomic) IBOutlet UITableView *repeatOptionTableView;

- (IBAction)selectDate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButtonView;

@property (weak, nonatomic) IBOutlet UIButton *endButtonView;


@property (strong, nonatomic) NSArray *repeatOptionList;
@property (strong, nonatomic) NSArray *selectList;

@end

@implementation ReminderDetailVC

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
    self.repeatOptionTableView.delegate = self;
    self.repeatOptionTableView.dataSource = self;
    self.repeatOptionList = [[NSArray alloc] initWithObjects:@"Every Sunday", @"Every Monday", @"Every Tuesday", @"Every Wednesday", @"Every Thursday", @"Every Friday", @"Every Saturday", nil];
    self.selectList = [[NSArray alloc] initWithObjects:@"Select Start Date", @"Select End Date", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - table delegate
- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repeatOptionList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"reminderOptionCell";
    
    UITableViewCell *cell = [self.repeatOptionTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.repeatOptionList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (cell.accessoryType == UITableViewCellAccessoryNone)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)
        return 0;
    else
        return 26;
}

- (IBAction)selectDate:(id)sender {
    NSLog(@"Come to select date!");
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@""
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:nil];
    
    // Add the picker
    UIDatePicker *pickerView = [[UIDatePicker alloc] init];
    pickerView.datePickerMode = UIDatePickerModeDate;
    [menu addSubview:pickerView];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0,0,320, 400)];
    
    CGRect pickerRect = pickerView.bounds;
    pickerView.bounds = pickerRect;
    int tag = [sender tag];
    // Set action listener
    if (tag == 0) {
        [pickerView addTarget:self
                   action:@selector(updateStartLabel:)
             forControlEvents:UIControlEventValueChanged];
    } else {
        [pickerView addTarget:self
                       action:@selector(updateEndLabel:)
             forControlEvents:UIControlEventValueChanged];
        
    }
}

- (void)updateStartLabel:(id)sender
{
    NSDate *myDate = [(UIDatePicker *)sender date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"cccc, MMM d"];
    NSString *dateString = [dateFormat stringFromDate:myDate];
    NSLog(@"The date is %@", dateString);
    [self.startButtonView setTitle:dateString forState:UIControlStateNormal];
}


- (void)updateEndLabel:(id)sender
{
    NSDate *myDate = [(UIDatePicker *)sender date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"cccc, MMM d"];
    NSString *dateString = [dateFormat stringFromDate:myDate];
    NSLog(@"The date is %@", dateString);
    
    [self.endButtonView setTitle:dateString forState:UIControlStateNormal];
}

@end
