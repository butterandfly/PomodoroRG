//
//  Mission.h
//  Tomatos
//
//  Created by Zero on 13-3-29.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Date;

@interface Mission : NSManagedObject

@property (nonatomic, retain) NSDate * createTime;
@property (nonatomic, retain) NSNumber * currentCount;
@property (nonatomic, retain) NSString * describtion;
@property (nonatomic, retain) NSNumber * targetCount;
@property (nonatomic, retain) NSNumber * isFinished;
@property (nonatomic, retain) NSNumber * interruptCount;
@property (nonatomic, retain) Date *inDate;

@end
