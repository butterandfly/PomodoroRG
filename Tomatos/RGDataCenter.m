//
//  RGDataCenter.m
//  Tomatos
//
//  Created by Zero on 13-3-26.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGDataCenter.h"
#import "RGAssistant.h"

@interface RGDataCenter ()

- (void)refleshAllDateExceptNewest;

@end

@implementation RGDataCenter

// Singleton function, get the data center.
// Infact it can be created in the starting point, no need to use sync.
+ (id)sharedDataCenter{
    __strong static id _dataCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataCenter = [[self alloc] init];
    });
    return _dataCenter;
}

- (id)init {
    if (self= [super init]) {
        _countOfAllDate = 0;
    }
    
    return self;
}

#pragma mark - Public functions

// Use this function to save changed.
- (void)save {
    NSError *err = nil;
    [self.managedObjectContext save:&err];
    if (err != nil) {
        // handle error
        NSLog(@"save error");
    }
}

// Add a new day(today only)
- (Date *)addDate {
    Date *newDay = (Date *)[NSEntityDescription insertNewObjectForEntityForName:@"Date" inManagedObjectContext:self.managedObjectContext];
    newDay.createTime = [NSDate date];
    newDay.dateName = [RGAssistant stringOfToday];
    
    NSError *err = nil;
    [self.managedObjectContext save:&err];
    if (err != nil) {
        // handle error
        NSLog(@"addDate error");
        return nil;
    }
    
    // Reflesh the date list.
    if (_allDateExceptNewest != nil) {
        [self refleshAllDateExceptNewest];
    }
    
    return newDay;
}

- (Mission *)addMissionWithDesc:(NSString *)desc targetCount:(NSNumber *)targetCount InDate:(Date *)inDate {
    // Create and setup the data object.
    Mission *mission = (Mission *)[NSEntityDescription insertNewObjectForEntityForName:@"Mission" inManagedObjectContext:self.managedObjectContext];
    
    mission.describtion = desc;
    mission.targetCount = targetCount;
    mission.currentCount = [NSNumber numberWithInt:0];
    mission.createTime = [NSDate date];
    [mission setInDate:inDate];
    
    NSError *err = nil;
    [self.managedObjectContext save:&err];
    if (err != nil) {
        //
        NSLog(@"error");
        return nil;
    }
    
    return mission;
}

- (BOOL)deleteMission:(Mission *)misstion {
    // delete mission
    [self.managedObjectContext deleteObject:misstion];
    
    NSError *err = nil;
    [self.managedObjectContext save:&err];
    if (err != nil) {
        // handle error
        NSLog(@"%@", err);
        return NO;
    }
    
    // success
    return YES;
}

- (NSMutableArray *)allDateExceptNewest {
    if (_allDateExceptNewest != nil) {
        return _allDateExceptNewest;
    }
    [self refleshAllDateExceptNewest];
    return _allDateExceptNewest;
}


- (Date *)newestDate {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Date" inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:NO];
    NSArray *sorters = [NSArray arrayWithObject:sorter];
    [request setSortDescriptors:sorters];
    [request setFetchLimit:1];
    
    NSError *err = nil;
    NSArray *resultArray = [_managedObjectContext executeFetchRequest:request error:&err];
    if (err != nil) {
        // handle error
        NSLog(@"RGError");
        return nil;
    }
    
    if ([resultArray count] == 0) {
        return nil;
    }
    
    return resultArray[0];
}

#pragma mark - Public memo methods

- (Memo *)addMemoWithInfo:(NSString *)info {
    Memo *memo = (Memo *)[NSEntityDescription insertNewObjectForEntityForName:@"Memo" inManagedObjectContext:self.managedObjectContext];
    
    memo.info = info;
    memo.createTime = [NSDate date];
    
    NSError *err = nil;
    [self.managedObjectContext save:&err];
    if (err != nil) {
        //
        NSLog(@"error");
        return nil;
    }
    
    return memo;
}

- (NSArray *)allMemo {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Memo" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:NO];
    NSArray *sorters = [NSArray arrayWithObject:sorter];
    [request setSortDescriptors:sorters];
    
    NSError *err = nil;
    NSArray *resultArray = [_managedObjectContext executeFetchRequest:request error:&err];
    if (err != nil) {
        // handle error
        NSLog(@"RGError");
        return nil;
    }
    
    return resultArray;
}

- (BOOL)deleteMemo:(Memo *)memo {
    // delete memo
    [self.managedObjectContext deleteObject:memo];
    
    NSError *err = nil;
    [self.managedObjectContext save:&err];
    if (err != nil) {
        // handle error
        NSLog(@"%@", err);
        return NO;
    }
    
    // success
    return YES;
}

- (BOOL)deleteDataObject:(id)object {
//    NSLog(@"%@", [object class]);
    // delete
    [self.managedObjectContext deleteObject:object];
    
    NSError *err = nil;
    [self.managedObjectContext save:&err];
    if (err != nil) {
        // handle error
        NSLog(@"%@", err);
        return NO;
    }
    // success
    return YES;
}

#pragma mark - Privated

- (void)refleshAllDateExceptNewest {
    //    NSLog(@"reflesh all date function");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Date" inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:NO];
    NSArray *sorters = [NSArray arrayWithObject:sorter];
    [request setSortDescriptors:sorters];
    [request setFetchOffset:1];
    
    NSError *err = nil;
    _allDateExceptNewest = [[_managedObjectContext executeFetchRequest:request error:&err] mutableCopy];
    if (err != nil) {
        // handle error
        NSLog(@"RGError");
    }
    
    self.countOfAllDate = [_allDateExceptNewest count];
    //    NSLog(@"all date count: %d", _countOfAllDate);
}

@end
