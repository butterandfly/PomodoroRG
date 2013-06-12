//
//  RGTodayTableViewController.h
//  TomatoApp
//
//  Created by Zero on 13-3-24.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Date.h"
#import "RGMissions.h"

@interface RGTodayTableViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *manageObjectContext;
@property (strong, nonatomic) RGMissions *missions;
@property (strong, nonatomic) Date *currentDay;
@property (assign) BOOL inHistory;

- (IBAction)newDay:(id)sender;
- (void)addMission:(id)sender;

@end
