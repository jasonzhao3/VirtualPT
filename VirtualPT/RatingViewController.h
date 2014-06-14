//
//  RatingViewController.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/27/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
- (IBAction)clickRatingButton:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *faceViews;

- (IBAction)cancelButton:(id)sender;
- (IBAction)doneButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *evaluationTable;
@property (weak, nonatomic) IBOutlet UILabel *positivePhrases;

@end
