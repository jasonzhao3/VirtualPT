//
//  GoalController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/26/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "GoalController.h"
#import "PageController.h"

@interface GoalController ()

@end

@implementation GoalController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //only after setting delegate could we make the table view showing the table data
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self createOptionList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createOptionList
{
    
    ListItem *item1 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Daily Routine.png"] text:@"Daily Routine"];
    ListItem *item2 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Do Exercise.png"] text:@"Exercise"];
    ListItem *item3 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Do Yoga.png"] text:@"Yoga"];
    ListItem *item4 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Drive Car.png"] text:@"Drive Car"];
    ListItem *item5 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Garden.png"] text:@"Garden"];

    ListItem *item6 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Go Fishing.png"] text:@"Go Fishing"];
    ListItem *item7 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Go out with friends.png"] text:@"Hang Out"];
    ListItem *item8 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Jump Rope.png"] text:@"Jump Rope"];
    ListItem *item9 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Play Basketball.png"] text:@"Play Basketball"];
    ListItem *item10= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Play Golf.png"] text:@"Play Golf"];
    
    ListItem *item11= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Play Tennis.png"] text:@"Play Tennis"];
    ListItem *item12= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Play with kids.png"] text:@"Play with kids"];
    ListItem *item13= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Return to Work.png"] text:@"Return to Work"];
    ListItem *item14= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Ride Bike.png"] text:@"Ride Bike"];
    
    ListItem *item15= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Rise from bed without assistance.png"] text:@"Rise from bed without assistance"];
    ListItem *item16= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Rise from wheelchair.png"] text:@"Rise from wheelchair"];
    ListItem *item17= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Run.png"] text:@"Run"];
    ListItem *item18= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Swim.png"] text:@"Swim"];
    ListItem *item19= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Walk Dog.png"] text:@"Walk Dog"];
    ListItem *item20= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Walk Stairs.png"] text:@"Walk Stairs"];
    
    ListItem *item21= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Walk without assistance.png"] text:@"Walk without assistance"];
    ListItem *item22= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Other.png"] text:@"Other"];
  
    // last nil works as a sentinel for the mutable array
    optionList1 = [[NSMutableArray alloc] initWithObjects: item1, item2, item3, item4, item5, item6, item7, item8, item9,  nil];
    optionList2 = [[NSMutableArray alloc] initWithObjects:item10, item11, item12, item13, item14, item15, item16, item17, item18, item19, item20, item21, item22, nil];

}

#pragma mark - table view delegate

- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 155.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"motivationOptionCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *title = @"";
    POHorizontalList *list;
    
    if ([indexPath row] == 0) {
        title = @"Functionality";
        
        list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:title items:optionList1];
    }
    else if ([indexPath row] == 1) {
        title = @"Leisure";
        
        list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:title items:optionList2];
    }

    
    
    
//    NSString *title = @"";
//    POHorizontalList *list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 200.0) title:title items:optionList];
    
    [list setDelegate:self];
    [cell.contentView addSubview:list];
    
    return cell;
}

#pragma mark  POHorizontalListDelegate

- (void) didSelectItem:(ListItem *)item {
    NSLog(@"Horizontal List Item %@ selected", item.imageTitle);
    //TODO: after clicking, the image/button status should change
    item.image =[UIImage imageNamed:@"select.png"];
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

- (IBAction)doneButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

    // The following is the disappear function for push segue
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0]  animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}
@end
