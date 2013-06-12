//
//  RGTomatoTimer.h
//  Tomatos
//
//  Created by Zero on 13-6-6.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGTomatoTimer : NSObject

@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger tomatoMin;


- (void)cancelTomatoTimer;

@end
