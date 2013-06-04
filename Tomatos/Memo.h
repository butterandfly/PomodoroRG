//
//  Memo.h
//  Tomatos
//
//  Created by Zero on 13-4-16.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Memo : NSManagedObject

@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSDate * createTime;

@end
