//
//  DailyCheckin.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/30/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface DailyCheckin : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSNumber * feel;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) User *checkinOfUser;

@end
