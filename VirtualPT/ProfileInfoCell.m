//
//  ProfileInfoCell.m
//  
//
//  Created by Jason Zhao on 5/16/14.
//
//

#import "ProfileInfoCell.h"

@implementation ProfileInfoCell
@synthesize profileImageView = _profileImageView;
@synthesize infoLabel = _infoLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
