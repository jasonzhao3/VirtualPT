//
//  AccomplishmentVC.m
//  
//
//  Created by Jason Zhao on 5/18/14.
//
//

#import "AccomplishmentVC.h"
#import "BadgeCell.h"
#import "BadgeDetailVC.h"
#import "PNChart.h"


#define CELL_HEIGHT 80

@interface AccomplishmentVC ()
@property (strong,nonatomic) NSArray *itemList;
@property (strong,nonatomic) NSArray *thumbnailList;

@property (strong, nonatomic) BadgeDetailVC *subVc;
@property (strong, nonatomic) NSDictionary *currentCate;
@end

@implementation AccomplishmentVC
@synthesize subVc=_subVc;
@synthesize folderTableView=_folderTableView;

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

    // set up tableview delegate
    self.folderTableView.delegate = self;
    self.folderTableView.dataSource = self;
    self.folderTableView.folderDelegate = self;

    self.folderTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_main"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_main"]];
    self.itemList = [[NSArray alloc] initWithObjects:@"Badges", @"Milestones", nil];
    self.thumbnailList = [[NSArray alloc] initWithObjects:@"newbie", @"PlayersClub", @"freedom", nil];
    [self drawBarPlot];
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
    return [self.itemList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"badgeCell";
    
    BadgeCell *cell = (BadgeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[BadgeCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    NSLog(@"item list is %@", [self.itemList objectAtIndex:indexPath.row]);
//    cell.img.image = [UIImage imageNamed:[self.itemList objectAtIndex:indexPath.row]];
    cell.img.image = [UIImage imageNamed:[self.thumbnailList objectAtIndex:indexPath.row]];
    cell.title.text = [self.itemList objectAtIndex:indexPath.row];
//    NSLog(@"title is %@", [self.itemList objectAtIndex:indexPath.row]);
    
    NSMutableArray *subTitles = [[NSMutableArray alloc] init];
    NSArray *subClass = [[NSArray alloc] initWithObjects:@"newbie", @"profession", @"swimmine", nil];

    for (int i=0; i < MIN(4,  subClass.count); i++) {
        [subTitles addObject:[subClass objectAtIndex:i]];
    }
    
    cell.subTtile.text = [subTitles componentsJoinedByString:@"/"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}


-(CGFloat)tableView:(UIFolderTableView *)tableView xForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BadgeDetailVC *subVc = [[BadgeDetailVC alloc] initWithNibName:@"BadgeDetailVC" bundle:nil];
//    NSDictionary *cate = [self.cates objectAtIndex:indexPath.row];
    subVc.badgeList = [[NSArray alloc] initWithObjects:@"newbie", @"freedom", @"cnn", @"swimmies", @"football", nil];
    
    subVc.parentVC = self;
    
    self.folderTableView.scrollEnabled = NO;
    UIFolderTableView *folderTableView = (UIFolderTableView *)tableView;
    [folderTableView openFolderAtIndexPath:indexPath WithContentView:subVc.view
                                 openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                     // opening actions
                                 }
                                closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                    // closing actions
                                }
                           completionBlock:^{
                               // completed actions
                               self.folderTableView.scrollEnabled = YES;
                           }];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - helpers

- (NSMutableAttributedString *)SetLabelAttributes:(NSString *)input size:(Size)size {
    
    NSMutableAttributedString *labelAttributes = [[NSMutableAttributedString alloc] initWithString:input];
    
    UIFont *font=[UIFont fontWithName:@"Helvetica Neue" size:size];
    
    NSMutableParagraphStyle* style = [NSMutableParagraphStyle new];
    style.alignment = NSTextAlignmentCenter;
    
    [labelAttributes addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, labelAttributes.length)];
    [labelAttributes addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, labelAttributes.length)];
    [labelAttributes addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, labelAttributes.length)];
    
    return labelAttributes;
}

#pragma mark - delegate method
// Delegate selector -- callback
-(void)subViewBtnAction:(UIButton *)btn
{
    
//    NSDictionary *subCate = [[self.currentCate objectForKey:@"subClass"] objectAtIndex:btn.tag];
//    NSString *name = [subCate objectForKey:@"name"];
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"Badge Detail"
                                                         message:@"A newbie badge is for the first time user"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    NSLog(@"click button %d", btn.tag);
    [Notpermitted show];
}




# pragma mark -- plot

- (void) drawBarPlot
{
	//Add BarChart
    UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, SCREEN_WIDTH, 20)];
    barChartLabel.text = @"Accumulated Exercise Hours";
    barChartLabel.textColor = PNFreshGreen;
    barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:18.0];
    barChartLabel.textAlignment = NSTextAlignmentCenter;
    
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 25.0, SCREEN_WIDTH, 180.0)];
    barChart.backgroundColor = [UIColor clearColor];
    [barChart setXLabels:@[@"04/01/14",@"04/02/14",@"04/03/14",@"04/04/14",@"04/05/14",@"04/06/14",@"04/07/14"]];
    [barChart setYValues:@[@3,@10,@20,@30,@40,@60,@90]];
    [barChart setStrokeColors:@[PNYellow,PNGreen,PNGreen,PNGreen,PNGreen,PNGreen,PNGreen]];
    [barChart strokeChart];
    
    [self.chartScrollView addSubview:barChartLabel];
    [self.chartScrollView addSubview:barChart];
    
}

# pragma mark - navigation
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
