//
//  BadgeDetailVC.m
//  VirtualPT
//
//  Created by Jason Zhao on 5/18/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "BadgeDetailVC.h"

#define COLUMN 4
#define ROWHEIHT 70

@interface BadgeDetailVC ()

@end

@implementation BadgeDetailVC

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
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_furley.png"]];
    
    // init cates show
    int total = self.badgeList.count;
    
    int rows = (total / COLUMN) + ((total % COLUMN) > 0 ? 1 : 0);
    
    for (int i=0; i<total; i++) {
        int row = i / COLUMN;
        int column = i % COLUMN;
        NSString *data = [self.badgeList objectAtIndex:i];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(80*column, ROWHEIHT*row, 80, ROWHEIHT)];
        view.backgroundColor = [UIColor clearColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15, 15, 50, 50);
        btn.tag = i;
        [btn addTarget:self.parentVC
                action:@selector(subViewBtnAction:)
      forControlEvents:UIControlEventTouchUpInside];
        
        [btn setBackgroundImage:[UIImage imageNamed:data]
                       forState:UIControlStateNormal];
        
        [view addSubview:btn];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, 80, 14)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor colorWithRed:204/255.0
                                        green:204/255.0
                                         blue:204/255.0
                                        alpha:1.0];
        lbl.font = [UIFont systemFontOfSize:12.0f];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.text = data;
        [view addSubview:lbl];
        
        [self.view addSubview:view];
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.size.height = ROWHEIHT * rows + 19;
    self.view.frame = viewFrame;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
