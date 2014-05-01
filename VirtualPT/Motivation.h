//
//  Motivation.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/30/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Motivation : NSManagedObject

@property (nonatomic, retain) NSString * q1;
@property (nonatomic, retain) NSString * q2;
@property (nonatomic, retain) NSString * q3;
@property (nonatomic, retain) NSString * q4;
@property (nonatomic, retain) NSString * q5;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) User *motivationOfUser;

@end
