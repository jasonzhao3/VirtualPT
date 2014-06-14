//
//  ProfileViewController.m
//  
//
//  Created by Jason Zhao on 5/14/14.
//
//

#import "ProfileViewController.h"
#import "ProfileInfoCell.h"

#define CELL_HEIGHT 47
#define THUMBNAIL_SIZE 45
#define PROFILE_CELL 75

#define HEADER_SIZE 12
#define FIRST_HEADER_SIZE 10
#define FOOTER_SIZE 12
#define ZERO 0.0f


@interface ProfileViewController ()
@property (strong,nonatomic) NSArray *profileArray;
@property (strong,nonatomic) NSArray *socialArray;
@property (strong,nonatomic) NSArray *settingArray;
@end

@implementation ProfileViewController

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
    self.profileTableView.dataSource = self;
    self.profileTableView.delegate = self;
    
    // custom cell
//    static NSString *CellIdentifier = @"profileInfoCell";
//    [self.profileTableView registerNib:[UINib nibWithNibName:@"ProfileInfoCell"  bundle:nil]  forCellReuseIdentifier:CellIdentifier];
    
    // Do any additional setup after loading the view.
    self.profileArray = [NSArray arrayWithObjects:@"Profile Photo", @"Name", @"Gender", @"Region", nil];
    self.socialArray = [NSArray arrayWithObjects:@"My Email", @"My Status", @"My QR Code", nil];
    self.settingArray = [NSArray arrayWithObjects:@"Reminder", @"Notification",  nil];
    
   
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [self.profileArray count];
    if (section == 1)
        return [self.socialArray count];
    else
        return [self.settingArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
        return PROFILE_CELL;
    else
        return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"profileImageCell";
//    if (indexPath.section == 0 && indexPath.row == 0)
//        CellIdentifier = @"profileImageCell";
//    else
//        CellIdentifier = @"profileCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileTableCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Custom tableview cell accessoryType
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"kitten"];
//        UIImageView *profileImage = [UIImageView alloc];
//        profileImage.frame = CGRectMake(10, 10, THUMBNAIL_SIZE, THUMBNAIL_SIZE);
//        profileImage.image = [UIImage imageNamed:@"kitten"];
//        [cell.contentView addSubview:profileImage];
//        cell.profileImageView.frame = CGRectMake(12, 3, THUMBNAIL_SIZE, THUMBNAIL_SIZE);
//        cell.profileImageView.image = [UIImage imageNamed:@"kitten"];
    }
    
    if (indexPath.section == 2) {
        UISwitch *onoffSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        [onoffSwitch addTarget:self action:@selector(flip:) forControlEvents:UIControlEventValueChanged];
        [onoffSwitch setOn:YES animated:YES];
        cell.accessoryView = onoffSwitch;
    }
    
    if (cell == nil) {
        cell = [[ProfileInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.profileArray objectAtIndex:indexPath.row];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = [self.socialArray objectAtIndex:indexPath.row];
    } else if (indexPath.section == 2) {
        cell.textLabel.text = [self.settingArray objectAtIndex:indexPath.row];
        
    }
    return cell;
}


- (void)flip:(id)sender {
    UISwitch *onoff = (UISwitch *)sender;
    NSLog(@"%@", onoff.on? @"On" : @"Off");
}


#pragma mark - header/footer view
- (UILabel *) newLabelWithTitle:(NSString *)paramTitle{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero]; label.text = paramTitle;
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    return label;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 0){
//        return [self newLabelWithTitle:@"Profile"];
//    } else if (section == 1){
//        return [self newLabelWithTitle:@"Social"];
//    } else if (section == 2) {
//        return [self newLabelWithTitle:@"Setting"];
//    } else
        return nil;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    //    if (section == 2){
    //        return [self newLabelWithTitle:@"VirtualPT 2014"];
    //    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return FIRST_HEADER_SIZE;
    }
    return HEADER_SIZE;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return FOOTER_SIZE;
    }
    return ZERO;
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

- (IBAction)cancelButton:(id)sender {        [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
