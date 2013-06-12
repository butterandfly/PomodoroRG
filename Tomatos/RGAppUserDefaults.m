//
//  RGAppUserDefaults.m
//  Tomatos
//
//  Created by Zero on 13-6-5.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGAppUserDefaults.h"
#import "RGConstant.h"

@implementation RGAppUserDefaults

+ (NSInteger)tomatoTime {
    NSInteger tMin = [[NSUserDefaults standardUserDefaults] integerForKey:kUserDefaultsTomatoTime];
    if (tMin == 0) {
        tMin = 25;
        [[NSUserDefaults standardUserDefaults] setInteger:tMin forKey:kUserDefaultsTomatoTime];
        
    }
    return tMin;
}

+ (void)setTomatoTime:(NSInteger)min{
    [[NSUserDefaults standardUserDefaults] setInteger:min forKey:kUserDefaultsTomatoTime];
}


@end
