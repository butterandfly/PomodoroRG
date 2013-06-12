//
//  RGTodayTableViewController.m
//  TomatoApp
//
//  Created by Zero on 13-3-24.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGTodayTableViewController.h"
#import "RGMissionViewCell.h"
#import "Mission.h"
#import "RGAppDelegate.h"
#import "Date.h"
#import "RGConstant.h"
#import "RGDateDataCenter.h"
#import "RGHelper.h"

@interface RGTodayTableViewController () {
    RGDateDataCenter *_dateDataCenter;
}

- (void)createNewDay;
- (void)checkIsOldDay;
- (void)insertARowAtTheTop;

@end

@implementation RGTodayTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _dateDataCenter = [RGDateDataCenter sharedRGDateDataCenter];
    
    if (!self.inHistory) {
        self.currentDay = [_dateDataCenter newestDate];
    }
    
    self.missions = [[RGMissions alloc] initWithDay:self.currentDay];
    
    if (!self.inHistory) {
        [self.missions addObserver:self forKeyPath:@"notFinishedCount" options:NSKeyValueObservingOptionNew context:NULL];
    }
    
    self.navigationItem.title = self.currentDay.dateName;
    [self.tableView setDataSource:self.missions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    // In check only view, we do nothing.
    if (self.inHistory) {
        return;
    }
    
    [self checkIsOldDay];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueId = [segue identifier];
    UIViewController *des = segue.destinationViewController;
    
    // add new mission
    if ([segueId isEqualToString:@"AddMission"]) {
        //
        [des setValue:self forKey:@"missionListDelegate"];
    }
    
    // edit mission
    if ([segueId isEqualToString:@"EditMission"]) {
        NSInteger row = [[self.tableView indexPathForCell:sender] row];
        [des setValue:self.missions.missionArray[row] forKey:@"currentMission"];
        [des setValue:self forKey:@"missionListDelegate"];
        [des setValue:[NSNumber numberWithInteger:kActionTagEdit] forKey:@"actionMode"];
        
    }
    
    // check mission
    if ([segueId isEqualToString:@"CheckMission"]) {
        NSInteger row = [[self.tableView indexPathForCell:sender] row];
        [des setValue:self.missions.missionArray[row] forKey:@"currentMission"];
        [des setValue:[NSNumber numberWithInteger:kActionTagCheck] forKey:@"actionMode"];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

#pragma mark - Action

- (IBAction)newDay:(id)sender {
    if ([self.currentDay.dateName isEqualToString:[RGHelper stringOfToday]]) {
        NSString *tip = NSLocalizedString(@"CurrentDayOnlyTip", nil);
        [RGHelper showOkAlertWithTitle:tip message:nil];
        return;
    }
    
    [self createNewDay];
}

- (void)addMission:(Mission *)mission  {
    [self.missions addMission:mission];
    
    // Update table view.
    [self insertARowAtTheTop];
}

#pragma mark - NSObject methods
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"notFinishedCount"]) {
        NSString *newBadge = [NSString stringWithFormat:@"%d", self.missions.notFinishedCount];
        [self setBadge:newBadge];
    }
}

#pragma mark - Alert delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self createNewDay];
    }
}

#pragma mark - private

- (void)setBadge:(NSString *)badge {
    [self.tabBarController.tabBar.items[0] setBadgeValue:badge];
}

- (void)createNewDay {
    [self.missions removeObserver:self forKeyPath:@"notFinishedCount"];
    
    self.currentDay = [_dateDataCenter addDate];
    self.missions = [[RGMissions alloc] initWithDay:self.currentDay];
    [self.missions addObserver:self forKeyPath:@"notFinishedCount" options:NSKeyValueObservingOptionNew context:NULL];
    
    // set title and reload table
    self.navigationItem.title = self.currentDay.dateName;
    [self.tableView reloadData];
}

- (void)checkIsOldDay {
    if (![self.currentDay.dateName isEqualToString:[RGHelper stringOfToday]]) {
        NSString *askStr = NSLocalizedString(@"NEWDAYTIP", nil);
        NSString *okStr = NSLocalizedString(@"OK", ni);
        NSString *cancelStr = NSLocalizedString(@"CANCEL", nil);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:askStr message:nil delegate:self cancelButtonTitle:cancelStr otherButtonTitles:okStr, nil];
        [alert show];
    }
}

- (void)insertARowAtTheTop {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


@end