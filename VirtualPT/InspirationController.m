//
//  InspirationController.m
//  VirtualPT
//
//  Created by Jason Zhao on 4/26/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "InspirationController.h"

@interface InspirationController ()
@property (nonatomic, weak) PFObject *motivation;
@end

@implementation InspirationController

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
    
    self.inspirationTableView.delegate = self;
    self.inspirationTableView.dataSource = self;
    
    VPTTabBarController * tabBar = (VPTTabBarController *)[self tabBarController];
    self.motivation = tabBar.motivation;

  
//    VPTTabBarController * tabBar = (VPTTabBarController *)[self tabBarController];
//    [tabBar setTitle:@"My Inspiration"];

    [self createOptionList];
    [self updateInspiration];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createOptionList
{
    
    // Self Inspiration
    ListItem *item1 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Faith and Spirituality.png"] text:@"Faith"];
    ListItem *item2 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Music.png"] text:@"Music"];
    ListItem *item3 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Nature.png"] text:@"Nature"];

    
    
    // Social Inspiration
    ListItem *item5 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Family.png"] text:@"Family"];
    ListItem *item6 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Friends.png"] text:@"Friends"];
    ListItem *item7 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Grandparent.png"] text:@"Grand Parent"];
    ListItem *item8 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"People with similar experiences.png"] text:@"Bonding"];
    ListItem *item9 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Significant Other.png"] text:@"Lover"];
    ListItem *item10 = [[ListItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"Other.png"] text:@"Other"];
    
    // last nil works as a sentinel for the mutable array
    optionList1 = [[NSMutableArray alloc] initWithObjects: item1, item2, item3, nil];
    optionList2 = [[NSMutableArray alloc] initWithObjects: item5, item6, item7, item8, item9, item10, nil];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"motivationOptionCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *title = @"";
    POHorizontalList *list;
    
    if ([indexPath row] == 0) {
        title = @"Self Inspirations";
        
        list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 155.0) title:title items:optionList1];
    }
    else if ([indexPath row] == 1) {
        title = @"Social Inspirations";
        
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
    //    NSLog(@"Horizontal List Item %@ selected", item.imageTitle);
    NSMutableArray *inspirations = self.motivation[@"inspiration"];
    if (!item.isSelected){
        item.checkView.image = [UIImage imageNamed:@"check"];
        [inspirations addObject:item.imageTitle];
    } else {
        item.checkView.image = [UIImage imageNamed:@"clear"];
        [inspirations removeObject:item.imageTitle];
    }
    
    self.motivation[@"inspiration"] = inspirations;
    NSLog(@"%@", self.motivation);
    
}

- (void)updateInspiration
{
    [self.motivation fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        //Again, be careful that we have to put everything in asynchrnous block
        NSArray *inspirations = self.motivation[@"inspiration"];
        for (ListItem *item in optionList1) {
            if ([inspirations containsObject: item.imageTitle])
                item.checkView.image = [UIImage imageNamed:@"check"];
        }
        for (ListItem *item in optionList2) {
            if ([inspirations containsObject: item.imageTitle])
                item.checkView.image = [UIImage imageNamed:@"check"];
        }
        
    }];
    
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


- (IBAction)saveButton:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
