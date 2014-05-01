//
//  User.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/30/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DailyCheckin, Motivation;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSSet *userHasDailyCheckin;
@property (nonatomic, retain) Motivation *userHasMotivation;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addUserHasDailyCheckinObject:(DailyCheckin *)value;
- (void)removeUserHasDailyCheckinObject:(DailyCheckin *)value;
- (void)addUserHasDailyCheckin:(NSSet *)values;
- (void)removeUserHasDailyCheckin:(NSSet *)values;

@end
