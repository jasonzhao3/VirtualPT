//
//  ReminderViewController.m
//  
//
//  Created by Jason Zhao on 5/27/14.
//
//

#import "ReminderViewController.h"
#import <EventKit/EventKit.h>
#define HEADER_SIZE 26
#define FOOTER_SIZE 26
#define ZERO 0.0f

@interface ReminderViewController () 
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UITableView *optionTableView;

@property (strong, nonatomic) NSArray *optionList;
@property (strong, nonatomic) EKEventStore *eventStore;
@end

@implementation ReminderViewController

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
    
    // set table delegate
    self.optionTableView.delegate = self;
    self.optionTableView.dataSource = self;
    self.optionList = [[NSArray alloc]initWithObjects:@"Repeat",@"Sound", @"On/Off", nil];
    self.textField.delegate = self;
    
    if (self.eventStore == nil) {
        self.eventStore = [[EKEventStore alloc] init];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 6.0) {
            // After version 6.0, need permission
            [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                if (granted) {
                    NSLog(@"用户允许使用“日历”！！！");
                } else {
                    NSLog(@"用户不允许使用“日历”！！！");
                }
                if (error) {
                    NSLog(@"申请“日历”权限error:%@", error);
                }
            }];
//            [self.eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
//                if (granted) {
//                    NSLog(@"用户允许使用“提醒事项”！！！");
//                } else {
//                    NSLog(@"用户不允许使用“提醒事项”！！！");
//                }
//                if (error) {
//                    NSLog(@"申请“提醒事项”权限error:%@", error);
//                }
//            }];
        }
    }
    // Do any additional setup after loading the view.
}


# pragma mark - table delegate
- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 3;
    else
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"reminderOptionCell";
    
    UITableViewCell *cell = [self.optionTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.optionList objectAtIndex:indexPath.row];
        if (indexPath.row != 2)
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        else {
            UISwitch *onoffSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
            [onoffSwitch addTarget:self action:@selector(flip:) forControlEvents:UIControlEventValueChanged];
            [onoffSwitch setOn:YES animated:YES];
            cell.accessoryView = onoffSwitch;
        }
    } else {
        cell.textLabel.text = @"Add Reminder to Calendar";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
    }
    return cell;
}

- (void)flip:(id)sender {
    UISwitch *onoff = (UISwitch *)sender;
    NSLog(@"%@", onoff.on? @"On" : @"Off");
}


- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return HEADER_SIZE;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return ZERO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    // Add to calendar
    if (indexPath.section == 1) {
        EKEvent *event = [EKEvent eventWithEventStore:self.eventStore];
        event.calendar = self.eventStore.defaultCalendarForNewEvents;
        event.allDay = NO;
        event.title = self.textField.text;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
        oneDayAgoComponents.minute = 2;
        NSDate *startDate = [calendar dateByAddingComponents:oneDayAgoComponents
                                                      toDate:[NSDate date]
                                                     options:0];
        
        NSDateComponents *oneYearFromNowComponents = [[NSDateComponents alloc] init];
        oneYearFromNowComponents.minute = 10;
        NSDate *endDate = [calendar dateByAddingComponents:oneYearFromNowComponents
                                                    toDate:[NSDate date]
                                                   options:0];
        
        event.startDate = startDate;
        event.endDate = endDate;
        
        // 加入提醒时间
        [event addAlarm:[EKAlarm alarmWithAbsoluteDate:startDate]];
        
        NSError *error = nil;
        [self.eventStore saveEvent:event span:EKSpanFutureEvents commit:YES error:&error];
        if (error) {
            NSLog(@"error!!! \n%@", error);
        }
    }
    // Edit detail information
    else {
        [self performSegueWithIdentifier:@"reminderDetailSegue" sender:[tableView cellForRowAtIndexPath:indexPath]];
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// function to remove keyboard when tapping anywhere else on the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:TRUE];
}



@end
