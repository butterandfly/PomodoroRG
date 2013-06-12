//
//  RGMissions.m
//  Tomatos
//
//  Created by Zero on 13-6-11.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGMissions.h"
#import "RGMissionViewCell.h"
#import "Mission.h"

@implementation RGMissions

- (id)initWithDay:(Date *)date {
    self = [super init];
    
    if (self) {
        // init mission array
        NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:NO];
        NSArray *sorters = [NSArray arrayWithObject:sorter];
        NSSet *missionSet = date.missions;
        self.missionArray = [[missionSet sortedArrayUsingDescriptors:sorters] mutableCopy];
        
        // Init notFinished stuff.
        _notFinishedMissions = [[NSMutableSet alloc] init];
        self.notFinishedCount = 0;
    }
    
    return self;
}

- (void)addMission:(Mission *)mission  {
    // Always update data source first.
    [self.missionArray insertObject:mission atIndex:0];
    
    [_notFinishedMissions addObject:mission];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Section[1] shows the sum count of tomatos.
    if (section == 1) {
        return 1;
    }
    
    return [self.missionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Section[1] shows the sum count of tomatos.
    if (indexPath.section == 1) {
        return [self sumCellInTableView:tableView atIndexPath:indexPath];
    }
    
    return [self missionCellInTableView:tableView atIndexPath:indexPath];
}

#pragma mark - Privated
- (UITableViewCell*)sumCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    //
    static NSString *currentCountCellId = @"CurrentCountCell";
    RGMissionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:currentCountCellId forIndexPath:indexPath];
    NSInteger currentCount = 0;
    for (Mission *mission in self.missionArray) {
        currentCount = currentCount + [mission.currentCount integerValue];
    }
    NSString *finishedCountTip = NSLocalizedString(@"FINISHEDCOUNTTIP", nil);
    cell.textLabel.text = [NSString stringWithFormat:finishedCountTip, currentCount];
    return cell;
}

- (UITableViewCell *)missionCellInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
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
        NSLog(@"----- count did set");
    }
    
    return cell;
}

@end
