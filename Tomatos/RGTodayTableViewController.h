//
//  RGTodayTableViewController.h
//  TomatoApp
//
//  Created by Zero on 13-3-24.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Date.h"

@interface RGTodayTableViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *manageObjectContext;
@property (strong, nonatomic) NSMutableArray *missionArray;
@property (strong, nonatomic) Date *currentDay;
@property (assign) BOOL inHistory;
@property (assign, nonatomic) BOOL notFinishedCount;
@property (strong, nonatomic) NSMutableSet *notFinishedMissions;

- (IBAction)newDay:(id)sender;
- (void)addMission:(id)sender;

@end
