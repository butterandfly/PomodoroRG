//
//  RGMemoDataCenter.m
//  Tomatos
//
//  Created by Zero on 13-6-7.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGMemoDataCenter.h"

@implementation RGMemoDataCenter

SYNTHESIZE_SINGLETON_FOR_CLASS(RGMemoDataCenter)

- (id)init {
    NSLog(@"RGMemoDataCenter init");
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (Memo *)addMemoWithInfo:(NSString *)info {
    Memo *memo = (Memo *)[NSEntityDescription insertNewObjectForEntityForName:@"Memo" inManagedObjectContext:self.managedObjectContext];
    
    memo.info = info;
    memo.createTime = [NSDate date];
    
    NSError *err = nil;
    [self.managedObjectContext save:&err];
    if (err != nil) {
        NSLog(@"error");
        return nil;
    }
    
    return memo;
}

- (NSArray *)allMemo {
    NSLog(@"allMemo function");
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Memo" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:NO];
    NSArray *sorters = [NSArray arrayWithObject:sorter];
    [request setSortDescriptors:sorters];
    
    NSError *err = nil;
    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&err];
    if (err != nil) {
        NSLog(@"RGError");
        return nil;
    }
    
    NSLog(@"in allMemo: %@", resultArray);
    return resultArray;
}

- (BOOL)deleteMemo:(Memo *)memo {
    [self.managedObjectContext deleteObject:memo];
    
    NSError *err = nil;
    [self.managedObjectContext save:&err];
    if (err != nil) {
        NSLog(@"%@", err);
        return NO;
    }
    
    return YES;
}
@end
