//
//  VPTMenuTableViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/2/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

/*
     @"Library",
// motivation: 5 question related  -- static
// exrcise  -- multiple segues with videos and descriptions, timer
// progress: count-down towards to finish line, function-related stories -- some milestone
 tap the image; minimize the text
 */

#import "VPTMenuTableViewController.h"
#import "VPTNavigationController.h"
#import "UtilitiesController.h"
#import "ProgressTableViewController.h"
#import "ExercisePreviewController.h"
#import "LoginViewController.h"
#import "AccomplishmentVC.h"
#import <Parse/Parse.h>

@interface VPTMenuTableViewController ()

@end

@implementation VPTMenuTableViewController
@synthesize tasksArray;


- (void)viewDidLoad
{
  
    [super viewDidLoad];
    
    
    PFUser *currUser = [PFUser currentUser];
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // set user profile image
////    if (currUser)
//    NSURL *profilePictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [currUser[@"authData"];
//    NSURLRequest *profilePictureURLRequest = [NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f]; // Facebook profile picture cache policy: Expires in 2 weeks
//    [NSURLConnection connectionWithRequest:profilePictureURLRequest delegate:self];
//                                                                                                                                     NSLog(@"URL is %@", profilePictureURL);
    
    
    
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//        
//        imageView.image = [UIImage imageNamed:@"kitten.png"];
//        imageView.layer.masksToBounds = YES;
//        imageView.layer.cornerRadius = 50.0;
//        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        imageView.layer.borderWidth = 3.0f;
//        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
//        imageView.layer.shouldRasterize = YES;
//        imageView.clipsToBounds = YES;
//        
//        //TODO: delegate this label to other UI
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text = currUser.username;
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        
        UIButton *profileButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        profileButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [profileButton setBackgroundImage:[UIImage imageNamed:@"kitten.png"] forState:UIControlStateNormal];
        profileButton.layer.masksToBounds = YES;
        profileButton.layer.cornerRadius = 50.0;
        profileButton.layer.borderColor = [UIColor whiteColor].CGColor;
        profileButton.layer.borderWidth = 3.0f;
        profileButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
        profileButton.layer.shouldRasterize = YES;
        profileButton.clipsToBounds = YES;
        
//        [view addSubview:imageView];
        [view addSubview:profileButton];
        [profileButton addTarget:self
                     action:@selector(showProfile)
           forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:label];
        view;
    });

        [self addLinearGradientToView:self.tableView withColor:[UIColor greenColor] transparentToOpaque:YES];
    self.tasksArray = [NSArray arrayWithObjects:@"My Motivations", @"My Training", @"My Accomplishments", @"Utilities", @"Log out", nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tasksArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        NSLog (@"nil cell");
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.tasksArray objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - TODO: view effect

// TODO: understand this block of this code for display
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = @"Friends Online";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}


#pragma mark -- controller switch
// It seems that we don't even need segue in storyboard -- this controller switch depends on controller identifier rather than segue
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VPTNavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"rootNavigationController"];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITabBarController *motivationTBC = [self.storyboard instantiateViewControllerWithIdentifier:@"motivationTBC"];
        navigationController.viewControllers = @[motivationTBC];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        ExercisePreviewController *myExerciseController = [self.storyboard instantiateViewControllerWithIdentifier:@"myExerciseController"];
        navigationController.viewControllers = @[myExerciseController];
    } else if (indexPath.section == 0 && indexPath.row == 2){
        AccomplishmentVC *accomplishmentController = [self.storyboard instantiateViewControllerWithIdentifier:@"accomplishmentController"];
        navigationController.viewControllers = @[accomplishmentController];
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        UtilitiesController *utilityController = [self.storyboard instantiateViewControllerWithIdentifier:@"utilityController"];
        navigationController.viewControllers = @[utilityController];
    } else {
        [PFUser logOut];
//        PFUser *currentUser = [PFUser currentUser]; // this will now be nil
        LoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginController"];
        navigationController.viewControllers = @[loginController];
    
        
        /* TODO: Alert Window
        UIAlertView *alert = [[UIAlertView alloc] init];
        
        [alert setTitle:@"Confirm"];
        [alert setMessage:@"Do you really want to logout?"];
        [alert setDelegate:self];
        [alert addButtonWithTitle:@"Yes"];
        [alert addButtonWithTitle:@"No"];
        [alert show];

         */
    }
    
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
        [PFUser logOut];
        //        PFUser *currentUser = [PFUser currentUser]; // this will now be nil
//        LoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginController"];
//        navigationController.viewControllers = @[loginController];
//        //        NSLog (@"Succesfully Log out!");
//        
//        Yang
        // Yes, do something
        NSLog(@"clicked yes!");
        LoginViewController *lc = [self.storyboard instantiateViewControllerWithIdentifier:@"loginController"];
        [self.navigationController pushViewController:lc animated:YES];
        
        //        [self.navigationController popViewControllerAnimated:YES];
        //        [self performSegueWithIdentifier:@"backLoginSegue" sender:nil];
    }
    else if (buttonIndex == 1)
    {
        // No
        NSLog(@"clicked no!");
    }
}

#pragma mark -- view size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}



#pragma mark - UI helper
- (void)addLinearGradientToView:(UIView *)theView withColor:(UIColor *)theColor transparentToOpaque:(BOOL)transparentToOpaque
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    //the gradient layer must be positioned at the origin of the view
    CGRect gradientFrame = theView.frame;
    gradientFrame.origin.x = 0;
    gradientFrame.origin.y = 0;
    gradient.frame = gradientFrame;
    
    //build the colors array for the gradient
    NSArray *colors = [NSArray arrayWithObjects:
//                       (id)[theColor CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.05f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.1f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.15f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.1f] CGColor],
                       (id)[[theColor colorWithAlphaComponent:0.05f] CGColor],
                       (id)[[UIColor clearColor] CGColor],
                       nil];
    
    //reverse the color array if needed
    if(transparentToOpaque)
    {
        colors = [[colors reverseObjectEnumerator] allObjects];
    }
    
    //apply the colors and the gradient to the view
    gradient.colors = colors;
    
    [theView.layer insertSublayer:gradient atIndex:0];
}


#pragma mark - profile button
- (void)showProfile
{
    [self performSegueWithIdentifier:@"showProfileSegue" sender:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
