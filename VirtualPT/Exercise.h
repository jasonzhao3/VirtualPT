//
//  Exercise.h
//  VirtualPT
//
//  Created by Jason Zhao on 4/30/14.
//  Copyright (c) 2014 Jason Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Exercise : NSManagedObject

@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * hold;
@property (nonatomic, retain) NSString * imgURL;
@property (nonatomic, retain) NSString * instruction;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * reps;
@property (nonatomic, retain) NSString * videoURL;
@property (nonatomic, retain) NSSet *exerciseBelongsToUsers;
@end

@interface Exercise (CoreDataGeneratedAccessors)

- (void)addExerciseBelongsToUsersObject:(User *)value;
- (void)removeExerciseBelongsToUsersObject:(User *)value;
- (void)addExerciseBelongsToUsers:(NSSet *)values;
- (void)removeExerciseBelongsToUsers:(NSSet *)values;

@end
