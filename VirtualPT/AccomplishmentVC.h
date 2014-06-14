//
//  AccomplishmentVC.h
//  
//
//  Created by Jason Zhao on 5/18/14.
//
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"
#import "VPTBaseViewController.h"

@interface AccomplishmentVC : VPTBaseViewController<UITableViewDataSource, UITableViewDelegate, UIFolderTableViewDelegate>

@property (weak, nonatomic) IBOutlet UIFolderTableView *folderTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *chartScrollView;


-(void)subViewBtnAction:(UIButton *)btn;
@end
