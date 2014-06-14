//
//  ListItem.h
//  POHorizontalList
//
//  Created by Polat Olu on 15/02/2013.
//  Copyright (c) 2013 Polat Olu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ListItem : UIView {
    CGRect textRect;
    CGRect imageRect;
}

@property (nonatomic, retain) NSObject *objectTag;

@property (nonatomic, retain) NSString *imageTitle;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIButton *imageButton;

@property (nonatomic, retain) UIImageView *checkView;

// add isSelected to each button other than maintain a list of isSelected status
// More memory and managment friendly in terms of selector
@property (nonatomic, assign) BOOL isSelected;

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)imageTitle;

@end
