//
//  RGMemoDataCenter.h
//  Tomatos
//
//  Created by Zero on 13-6-7.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGCoreDataCenter.h"
#import "Memo.h"
#import "RGSingletonTemplate.h"

@interface RGMemoDataCenter : RGCoreDataCenter

SYNTHESIZE_SINGLETON_FOR_HEADER(RGMemoDataCenter)

- (Memo*)addMemoWithInfo:(NSString*)info;
- (NSArray*)allMemo;
- (BOOL)deleteMemo:(Memo*)memo;

@end
