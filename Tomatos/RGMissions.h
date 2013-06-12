//
//  RGMissions.h
//  Tomatos
//
//  Created by Zero on 13-6-11.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Date.h"

@interface RGMissions : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *missionArray;
@property (strong, nonatomic) NSMutableSet *notFinishedMissions;
@property (assign, nonatomic) BOOL notFinishedCount;

- (id)initWithDay:(Date*)date;
- (void)addMission:(Mission *)mission;
    
@end
