//
//  RGAppDelegate.h
//  Tomatos
//
//  Created by Zero on 13-3-24.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGDataCenter.h"

@interface RGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong) RGDataCenter *dataCenter;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
