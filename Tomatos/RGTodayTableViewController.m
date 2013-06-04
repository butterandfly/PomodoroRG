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
#import "RGDataCenter.h"
#import "RGAssistant.h"
#import "RGConstant.h"

@interface RGTodayTableViewController () {
    RGDataCenter *_dataCenter;
}

- (void)createNewDay;

@end

@implementation RGTodayTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _dataCenter = [RGDataCenter sharedDataCenter];
    
    // history view or today view
    if (self.inHistory) {
    } else {
        self.currentDay = [_dataCenter newestDate];
        // if there is no data yet, build a new day
        if (self.currentDay == nil) {
            [self createNewDay];
        }
        _notFinishedMissions = [[NSMutableSet alloc] init];
        self.notFinishedCount = 0;
        // observer the count of not-finished tomatos
        [self addObserver:self forKeyPath:@"notFinishedCount" options:NSKeyValueObservingOptionNew context:NULL];
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.title = self.currentDay.dateName;
    
    // init mission array
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:NO];
    NSArray *sorters = [NSArray arrayWithObject:sorter];
    NSSet *missionSet = self.currentDay.missions;
    self.missionArray = [[missionSet sortedArrayUsingDescriptors:sorters] mutableCopy];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    // in check only view, we do nothing
    if (self.inHistory) {
        return;
    }
    
    if (![self.currentDay.dateName isEqualToString:[RGAssistant stringOfToday]]) {
        // alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前列表已过期，要创建新的一天吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
        [alert show];
    }
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
        [des setValue:self.missionArray[row] forKey:@"currentMission"];
        [des setValue:self forKey:@"missionListDelegate"];
        [des setValue:[NSNumber numberWithInteger:kActionTagEdit] forKey:@"actionMode"];
        
    }
    
    // check mission
    if ([segueId isEqualToString:@"CheckMission"]) {
        NSInteger row = [[self.tableView indexPathForCell:sender] row];
        [des setValue:self.missionArray[row] forKey:@"currentMission"];
        [des setValue:[NSNumber numberWithInteger:kActionTagCheck] forKey:@"actionMode"];
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    return [self.missionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        //
        NSString *currentCountCellId = @"CurrentCountCell";
        RGMissionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:currentCountCellId forIndexPath:indexPath];
        NSInteger currentCount = 0;
        for (Mission *mission in self.missionArray) {
            currentCount = currentCount + [mission.currentCount integerValue];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"已完成%d个番茄", currentCount];
        return cell;
    }
    
    static NSString *CellIdentifier = @"MissionCell";
    RGMissionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Mission *mission = self.missionArray[indexPath.row];
    cell.describtionLabel.text = mission.describtion;
    cell.finishedLabel.text = [NSString stringWithFormat:@"%@/%@", mission.currentCount, mission.targetCount];
    if ([mission.isFinished boolValue]) {
        cell.describtionLabel.textColor = [UIColor grayColor];
    } else {
        cell.describtionLabel.textColor = [UIColor blackColor];
        [_notFinishedMissions addObject:mission];
        self.notFinishedCount = [_notFinishedMissions count];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

#pragma mark - Action

- (IBAction)newDay:(id)sender {
    // get today string
    NSString *dateString = [RGAssistant stringOfToday];
    
    if ([self.currentDay.dateName isEqualToString:dateString]) {
        // alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你只能创建当天的任务列表" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else {
        [self createNewDay];
    }
    
}

- (void)addMission:(Mission *)mission  {
    // add into missionArray
    [self.missionArray insertObject:mission atIndex:0];
    // add into notFinishedMissions
    [_notFinishedMissions addObject:mission];
    // add into table view
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - NSObject methods
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // observe notFiniishedCount
    if ([keyPath isEqualToString:@"notFinishedCount"]) {
        //
        NSString *newBadge = [NSString stringWithFormat:@"%d", self.notFinishedCount];
        [self setBadge:newBadge];
    }
}

#pragma mark - Alert delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // create a new day
        [self createNewDay];
    }
}

#pragma mark - private

- (void)setBadge:(NSString *)badge {
    [self.tabBarController.tabBar.items[0] setBadgeValue:badge];
}

- (void)createNewDay {
    self.currentDay = [_dataCenter addDate];
    // new missions array
    self.missionArray = [[NSMutableArray alloc] init];
    // new not-finished-missions set and record
    self.notFinishedCount = 0;
    self.notFinishedMissions = [[NSMutableSet alloc] init];
    
    // set title and reload table
    self.navigationItem.title = self.currentDay.dateName;
    [self.tableView reloadData];
}


@end