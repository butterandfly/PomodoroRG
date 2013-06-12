//
//  RGCoreDataCenter.h
//  Tomatos
//
//  Created by Zero on 13-6-7.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

@interface RGCoreDataCenter : NSObject

@property (weak) NSManagedObjectContext *managedObjectContext;

- (void)save;
- (BOOL)deleteDataObject:(id)object;
    
@end
