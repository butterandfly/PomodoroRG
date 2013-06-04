//
//  RGAssistant.h
//  Tomatos
//
//  Created by Zero on 13-4-8.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGAssistant : NSObject

// This function helps to get the string of today.
+ (NSString *)stringOfToday;
// This function helps to get the string of specific date.
+ (NSString *)stringOfDate:(NSDate *)date;

@end
