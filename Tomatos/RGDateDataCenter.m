//
//  RGDateDataCenter.m
//  Tomatos
//
//  Created by Zero on 13-6-7.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGDateDataCenter.h"
#import "RGHelper.h"

@interface RGDateDataCenter ()

- (void)refleshAllDateExceptNewest;

@end

@implementation RGDateDataCenter

SYNTHESIZE_SINGLETON_FOR_CLASS(RGDateDataCenter)

- (id)init {
    self = [super init];
    if (self) {
        _countOfAllDate = 0;
    }
    return self;
}

- (Date *)addDate {
    Date *newDay = (Date *)[NSEntityDescription insertNewObjectForEntityForName:@"Date" inManagedObjectContext:self.managedObjectContext];
    newDay.createTime = [NSDate date];
    newDay.dateName = [RGHelper stringOfToday];
    
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

- (NSMutableArray *)allDateExceptNewest {
    if (_allDateExceptNewest != nil) {
        return _allDateExceptNewest;
    }
    [self refleshAllDateExceptNewest];
    return _allDateExceptNewest;
}


- (Date *)newestDate {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Date" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:NO];
    NSArray *sorters = [NSArray arrayWithObject:sorter];
    [request setSortDescriptors:sorters];
    [request setFetchLimit:1];
    
    NSError *err = nil;
    NSArray *resultArray = [[self managedObjectContext] executeFetchRequest:request error:&err];
    if (err != nil) {
        NSLog(@"RGError");
        return nil;
    }
    
    if ([resultArray count] == 0) {
//        return nil;
        return [self addDate];
    }
    
    return resultArray[0];
}

#pragma mark - Privated

- (void)refleshAllDateExceptNewest {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Date" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:NO];
    NSArray *sorters = [NSArray arrayWithObject:sorter];
    [request setSortDescriptors:sorters];
    [request setFetchOffset:1];
    
    NSError *err = nil;
    _allDateExceptNewest = [[self.managedObjectContext executeFetchRequest:request error:&err] mutableCopy];
    if (err != nil) {
        NSLog(@"RGError");
    }
    
    self.countOfAllDate = [_allDateExceptNewest count];
}

@end
