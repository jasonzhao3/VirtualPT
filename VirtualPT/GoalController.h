//
//  GoalController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/26/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POHorizontalList.h"
#import "VPTTabBarController.h"
@interface GoalController : UIViewController <UITableViewDelegate, UITableViewDataSource, POHorizontalListDelegate> {
    NSMutableArray *optionList1;
    NSMutableArray *optionList2;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
