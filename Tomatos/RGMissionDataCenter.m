//
//  RGMissionDataCenter.m
//  Tomatos
//
//  Created by Zero on 13-6-7.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGMissionDataCenter.h"

@implementation RGMissionDataCenter

SYNTHESIZE_SINGLETON_FOR_CLASS(RGMissionDataCenter)

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
    [self.managedObjectContext deleteObject:misstion];
    
    NSError *err = nil;
    [self.managedObjectContext save:&err];
    if (err != nil) {
        NSLog(@"%@", err);
        return NO;
    }
    
    return YES;
}

@end
