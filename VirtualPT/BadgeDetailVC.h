//
//  BadgeDetailVC.h
//  VirtualPT
//
//  Created by Jason Zhao on 5/18/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccomplishmentVC.h"
@interface BadgeDetailVC : UIViewController

@property (strong, nonatomic) AccomplishmentVC *parentVC;
@property (strong, nonatomic) NSArray *badgeList;

@end
