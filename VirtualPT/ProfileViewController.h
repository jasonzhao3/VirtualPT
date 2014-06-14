//
//  ProfileViewController.h
//  
//
//  Created by Jason Zhao on 5/14/14.
//
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
- (IBAction)cancelButton:(id)sender;
- (IBAction)saveButton:(id)sender;


@end
