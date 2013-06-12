//
//  RGTomatoTimer.m
//  Tomatos
//
//  Created by Zero on 13-6-6.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGTomatoTimer.h"

@implementation RGTomatoTimer

- (id)init {
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (void)cancelTomatoTimer {
    [self.timer invalidate];
    self.timer = nil;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

// This functions helps to send the notification.
- (void)sendNotificationWithDate:(NSDate *)fireDate {
    // * Create a notifiction.
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = fireDate;
    notification.alertBody = @"完成一个番茄！";
    notification.alertAction = @"确定";
    notification.soundName = @"alarm2.mp3";
    
    // Schedule.
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

/*
- (void)releaseAllStuff {
    // Cancel timer.
    [self cancelTimer];
    // Cancel audio player.
//    _musicPlayer = nil;
    // Cancel notification.
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // Remove observer.
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)cancelTimer {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
 */

@end
