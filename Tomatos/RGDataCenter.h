//
//  RGDataCenter.h
//  Tomatos
//
//  Created by Zero on 13-3-26.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Date.h"
#import "Mission.h"
#import "Memo.h"

// RGDataCenter helps to manage the coredata.
// Use the sharedDataCenter function to get the singleton.
@interface RGDataCenter : NSObject

@property (nonatomic, strong) NSMutableArray *allDateExceptNewest;
@property (nonatomic, strong, readonly) Date *newestDate;
// A weak reference to get the app's managedObjectContext.
@property (weak) NSManagedObjectContext *managedObjectContext;
@property (assign, nonatomic) NSInteger countOfAllDate;

+ (id)sharedDataCenter;

// Save change.
- (void)save;

// * Methods 4 date.
- (Date *)addDate;

// * Methods 4 mission.
- (Mission *)addMissionWithDesc:(NSString *)desc targetCount:(NSNumber *)targetCount InDate:(Date *)inDate ;
- (BOOL)deleteMission:(Mission *)misstion;

// * Methods 4 memo.
- (Memo*)addMemoWithInfo:(NSString*)info;
- (NSArray *)allMemo;
- (BOOL)deleteMemo:(Memo*)memo;

- (BOOL)deleteDataObject:(id)object;

@end
