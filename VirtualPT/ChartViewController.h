//
//  ChartViewController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/13/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *chartScrollView;
@property (nonatomic, strong) NSString *titleString;

@end
