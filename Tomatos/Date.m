//
//  Date.m
//  Tomatos
//
//  Created by Zero on 13-3-29.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "Date.h"
#import "Mission.h"


@implementation Date

@dynamic createTime;
@dynamic dateName;
@dynamic missions;

- (NSInteger)tomatoCount {
    NSInteger count = 0;
    for (Mission *mission in self.missions) {
        //
        count = count + mission.currentCount.integerValue;
    }
    return count;
}

@end
