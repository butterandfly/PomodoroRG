//
//  Date.h
//  Tomatos
//
//  Created by Zero on 13-3-29.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Mission;

@interface Date : NSManagedObject

@property (nonatomic, retain) NSDate * createTime;
@property (nonatomic, retain) NSString * dateName;
@property (nonatomic, retain) NSSet *missions;
@end

@interface Date (CoreDataGeneratedAccessors)

- (void)addMissionsObject:(Mission *)value;
- (void)removeMissionsObject:(Mission *)value;
- (void)addMissions:(NSSet *)values;
- (void)removeMissions:(NSSet *)values;

// custom
- (NSInteger)tomatoCount;

@end
