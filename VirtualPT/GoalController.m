//
//  GoalController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/26/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "GoalController.h"
#import "MotivationViewController.h"

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
    
    // Daily Activities
    ListItem *item1 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Daily Routine.png"] text:@"Daily Routine"];
    ListItem *item2 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Work.png"] text:@"Work"];
    ListItem *item3 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Walk.png"] text:@"Walk"];
    ListItem *item4 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Bike.png"] text:@"Bike"];
    ListItem *item5 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Drive.png"] text:@"Drive"];
    ListItem *item6 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Play with kids.png"] text:@"Play with kids"];
    ListItem *item7 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Rise from bed.png"] text:@"Rise from bed"];
    ListItem *item8 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Rise from wheelchair.png"] text:@"Rise from wheelchair"];
    ListItem *item9 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Walk Stairs.png"] text:@"Walk Stairs"];
  

    // For Fun
    ListItem *item10 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Basketball.png"] text:@"Basketball"];
    ListItem *item11= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Golf.png"] text:@"Golf"];
    ListItem *item12= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Tennis.png"] text:@"Tennis"];
    ListItem *item13= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Fish.png"] text:@"Fishing"];
    ListItem *item14= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Garden.png"] text:@"Garden"];
    ListItem *item15= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Go Out.png"] text:@"Go Out"];
    ListItem *item16= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Run.png"] text:@"Run"];
    ListItem *item17= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Swim.png"] text:@"Swim"];
    ListItem *item18= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Yoga.png"] text:@"Yoga"];
    ListItem *item19= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Walk Dog.png"] text:@"Walk Dog"];
    ListItem *item20= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Exercise.png"] text:@"Exercise"];
    ListItem *item21= [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Jump Rope.png"] text:@"Jump Rope"];
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
        title = @"Daily Acitivities";
        
        list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:title items:optionList1];
    }
    else if ([indexPath row] == 1) {
        title = @"Fun";
        
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

@end
