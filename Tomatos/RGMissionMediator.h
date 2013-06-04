//
//  RGMissionMediator.h
//  Tomatos
//
//  Created by Zero on 13-4-17.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGDataCenter.h"

@class RGMissionViewController;
@class RGTodayTableViewController;

// RGMissionMediator helps manage the action of the RGMissionViewController.
@interface RGMissionMediator : NSObject

// Weak reference to data center, it can be private.
@property (weak, nonatomic) RGDataCenter *dataCenter;
// Weak reference to mission controller and mission list controller.
@property (weak, nonatomic) RGMissionViewController *missionController;
@property (weak, nonatomic) RGTodayTableViewController *dayController;

// * Actions of the UI of the mission controller.

- (IBAction)leftTopButton:(UIBarButtonItem *)sender;
- (IBAction)rightTopButtonClick:(UIBarButtonItem *)sender;
- (IBAction)steperStep:(UIStepper *)sender;
- (IBAction)toggleFinished:(UISwitch *)sender;

// * Actions will be use in the mission controller.

- (void)deleteMission;
// Enter timer controller and start timer.
- (void)startTimer;
// Save describtion data.
- (void)saveDescribtion;
- (void)stepperPlusOneByTag:(NSInteger)stepperTag;
- (void)updateCurrentCountCell;
// This function will update the list controller.
- (void)updateCellByIndexPath:(NSIndexPath*)indexPath;
// This function will update the list controller.
- (void)updateCellByMission:(Mission *)mission;

@end
