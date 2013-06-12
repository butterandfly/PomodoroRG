//
//  RGCoreDataCenter.m
//  Tomatos
//
//  Created by Zero on 13-6-7.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGCoreDataCenter.h"
#import "RGAppDelegate.h"

@implementation RGCoreDataCenter

- (id)init {
    self = [super init];
    if (self) {
        RGAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegate.managedObjectContext;
    }
    return self;
}

- (void)save {
    NSError *err = nil;
    [self.managedObjectContext save:&err];
    if (err != nil) {
        // handle error
        NSLog(@"save error");
    }
}

- (BOOL)deleteDataObject:(id)object {
    [self.managedObjectContext deleteObject:object];
    
    NSError *err = nil;
    [self.managedObjectContext save:&err];
    if (err != nil) {
        NSLog(@"%@", err);
        return NO;
    }
    
    return YES;
}

@end
