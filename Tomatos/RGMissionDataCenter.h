//
//  RGMissionDataCenter.h
//  Tomatos
//
//  Created by Zero on 13-6-7.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGCoreDataCenter.h"
#import "RGSingletonTemplate.h"
#import "Mission.h"
#import "Date.h"

@interface RGMissionDataCenter : RGCoreDataCenter

SYNTHESIZE_SINGLETON_FOR_HEADER(RGMissionDataCenter)

- (Mission *)addMissionWithDesc:(NSString *)desc targetCount:(NSNumber *)targetCount InDate:(Date *)inDate ;
- (BOOL)deleteMission:(Mission *)misstion;

@end
