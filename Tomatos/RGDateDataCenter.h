//
//  RGDateDataCenter.h
//  Tomatos
//
//  Created by Zero on 13-6-7.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGCoreDataCenter.h"
#import "RGSingletonTemplate.h"
#import "Date.h"

@interface RGDateDataCenter : RGCoreDataCenter

@property (nonatomic, strong) NSMutableArray *allDateExceptNewest;
@property (nonatomic, strong, readonly) Date *newestDate;
// A weak reference to get the app's managedObjectContext.
@property (assign, nonatomic) NSInteger countOfAllDate;

SYNTHESIZE_SINGLETON_FOR_HEADER(RGDateDataCenter)

- (Date *)addDate;

@end
