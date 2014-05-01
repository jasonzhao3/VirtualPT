//
//  User.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/30/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DailyCheckin, Exercise, Motivation;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSSet *userHasDailyCheckin;
@property (nonatomic, retain) NSSet *userHasMotivation;
@property (nonatomic, retain) NSSet *userHasExercises;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addUserHasDailyCheckinObject:(DailyCheckin *)value;
- (void)removeUserHasDailyCheckinObject:(DailyCheckin *)value;
- (void)addUserHasDailyCheckin:(NSSet *)values;
- (void)removeUserHasDailyCheckin:(NSSet *)values;

- (void)addUserHasMotivationObject:(Motivation *)value;
- (void)removeUserHasMotivationObject:(Motivation *)value;
- (void)addUserHasMotivation:(NSSet *)values;
- (void)removeUserHasMotivation:(NSSet *)values;

- (void)addUserHasExercisesObject:(Exercise *)value;
- (void)removeUserHasExercisesObject:(Exercise *)value;
- (void)addUserHasExercises:(NSSet *)values;
- (void)removeUserHasExercises:(NSSet *)values;

@end
