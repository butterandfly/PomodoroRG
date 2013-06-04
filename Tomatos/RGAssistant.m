//
//  RGAssistant.m
//  Tomatos
//
//  Created by Zero on 13-4-8.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGAssistant.h"

@implementation RGAssistant


+ (NSString *)stringOfDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateStyle:NSDateFormatterFullStyle];
    //    [formatter setTimeStyle:NSDateFormatterFullStyle];
    //    [formatter setDateFormat:@"yyyy-mm-dd"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSString *)stringOfToday {
    NSDate *now = [NSDate date];
    return [self stringOfDate:now];
}

@end
