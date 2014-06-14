//
//  ProgressTableViewController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/13/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "ProgressTableViewController.h"
#import "ChartViewController.h"

@interface ProgressTableViewController ()

@end

@implementation ProgressTableViewController

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
    [self setCustomNavigationButton];
    
    self.progressList = [NSArray arrayWithObjects:@"Daily Exercise Hours", @"Daily Feelings", @"Recovery Process", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.progressList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"progressCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        NSLog (@"nil cell");
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.progressList objectAtIndex:indexPath.row];
    return cell;}


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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"progressSegue"])
    {
        // Get reference to the destination view controller
        ChartViewController *cvc = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        // Pass any objects to the view controller here, like...
        [cvc setTitleString: [self.progressList objectAtIndex:indexPath.row]];
    }
}


- (void)setCustomNavigationButton
{
    UIImage* img = [UIImage imageNamed:@"menu"];
    CGRect frameimg = CGRectMake(0, 0, BAR_BUTTON_SIZE, BAR_BUTTON_SIZE);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:img forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(backToMenueSegue)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem=backButton;
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
