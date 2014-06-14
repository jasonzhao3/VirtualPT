//
//  ListItem.m
//  POHorizontalList
//
//  Created by Polat Olu on 15/02/2013.
//  Copyright (c) 2013 Polat Olu. All rights reserved.
//

#import "ListItem.h"

@implementation ListItem

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)imageTitle
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //TODO: change item list to button list
//        
//        self.imageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 72.0, 72.0)];
//        [self.imageButton setBackgroundImage:image forState:UIControlStateNormal];
//        self.imageButton.frame = CGRectMake(0.0, 0.0, 72.0, 72.0);

        
        [self setUserInteractionEnabled:YES];
        
        self.imageTitle = imageTitle;
        self.image = image;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

        CALayer *roundCorner = [imageView layer];
        [roundCorner setMasksToBounds:YES];
        [roundCorner setCornerRadius:8.0];
        [roundCorner setBorderColor:[UIColor blackColor].CGColor];
        [roundCorner setBorderWidth:1.0];
        
        UILabel *title = [[UILabel alloc] init];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setFont:[UIFont boldSystemFontOfSize:12.0]];
        [title setOpaque: NO];
        [title setText:imageTitle];
        
        imageRect = CGRectMake(0.0, 0.0, 72.0, 72.0);
        textRect = CGRectMake(0.0, imageRect.origin.y + imageRect.size.height, 80.0, 20.0);
        
        [title setFrame:textRect];
        [imageView setFrame:imageRect];
        //        [imageView setFrame:self.imageButton.frame];
        
        [self addSubview:title];
        [self addSubview:imageView];

        // initialized to No
        self.isSelected = NO;
        self.checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clear"]];
        // setFrame should be after set image
        [self.checkView setFrame:CGRectMake(0.0, 0.0, 32.0, 32.0)];
        [self addSubview:self.checkView];
    }
    
    return self;
}



@end
