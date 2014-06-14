//
//  BadgeCell.m
//  VirtualPT
//
//  Created by Jason Zhao on 5/18/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import "BadgeCell.h"

@implementation BadgeCell

@synthesize img=_img;
@synthesize title=_title;
@synthesize subTtile=_subTtile;


// Has to be initWithCoder rather than initWithStyle  -- has trapped me for quite a while
-(id)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"initWithCoder");
    
    self = [super initWithCoder: aDecoder];
    if (self)
    {
        // Initialization code
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tmall_bg_main"]];
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 58, 58)];
        self.img.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.img];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, 220, 20)];
        self.title.font = [UIFont systemFontOfSize:16.0f];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.opaque = NO;
        [self.contentView addSubview:self.title];
        
        self.subTtile = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 230, 14)];
        self.subTtile.font = [UIFont systemFontOfSize:12.0f];
        self.subTtile.textColor = [UIColor colorWithRed:158/255.0
                                                  green:158/255.0
                                                   blue:158/255.0
                                                  alpha:1.0];
        self.subTtile.backgroundColor = [UIColor clearColor];
        self.subTtile.opaque = NO;
        [self.contentView addSubview:self.subTtile];
        
//        UILabel *sLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 78, 320, 1)];
//        sLine1.backgroundColor = [UIColor colorWithRed:198/255.0
//                                                 green:198/255.0
//                                                  blue:198/255.0
//                                                 alpha:1.0];
//        UILabel *sLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 79, 320, 1)];
//        sLine2.backgroundColor = [UIColor whiteColor];
//        
//        [self.contentView addSubview:sLine1];
//        [self.contentView addSubview:sLine2];
        

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
