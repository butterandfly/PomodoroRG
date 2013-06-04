//
//  RGMissionMediator.m
//  Tomatos
//
//  Created by Zero on 13-4-17.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGMissionMediator.h"
#import "RGTodayTableViewController.h"
#import "RGMissionViewController.h"
#import "Mission.h"

@implementation RGMissionMediator

- (id)init
{
    self = [super init];
    if (self) {
        self.dataCenter = [RGDataCenter sharedDataCenter];
    }
    return self;
}

- (void)leftTopButton:(UIBarButtonItem *)sender {
    // Reflesh the cell in mission list.
    // Do this to make sure the list will load the newest info.
    [self updateCellByMission:self.missionController.currentMission];
    
    // Pop.
    [self.missionController.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightTopButtonClick:(UIBarButtonItem *)sender {
    // Go to another view.
    [self.missionController performSegueWithIdentifier:@"MissionConfig" sender:sender];
}

- (void)steperStep:(UIStepper *)sender {
    NSString *stepperType = [sender restorationIdentifier];
    // Get the name.
    NSString *labelName = [NSString stringWithFormat:@"%@Label", stepperType];
    UILabel *lbl = [self.missionController valueForKey:labelName];
    NSString *countName = [NSString stringWithFormat:@"%@Count", stepperType];
    // Set label.
    lbl.text = [NSString stringWithFormat:@"%d", (int)sender.value];
    // Save data.
    [self.missionController.currentMission setValue:[NSNumber numberWithDouble:sender.value] forKey:countName];
    [_dataCenter save];
    
    if ([stepperType isEqualToString:@"current"]) {
        // update cell
        [self updateCurrentCountCell];
    }
}

- (IBAction)toggleFinished:(UISwitch *)sender {
    Mission *currentMission = self.missionController.currentMission;
    // save data
    currentMission.isFinished = [NSNumber numberWithBool:sender.isOn];
    [_dataCenter save];
    // update data cell
    if ([[currentMission isFinished] boolValue]) {
        [self.dayController.notFinishedMissions removeObject:currentMission];
    } else {
        [self.dayController.notFinishedMissions addObject:currentMission];
    }
    self.dayController.notFinishedCount = [self.dayController.notFinishedMissions count];
}

- (void)deleteMission {
    Mission *mission = self.missionController.currentMission;
    
    [_dataCenter deleteMission:mission];
    
    // get info
    NSInteger section = 0;
    NSInteger row = [self.dayController.missionArray indexOfObject:mission];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    // delete from missionArray
    [self.dayController.missionArray removeObjectAtIndex:row];
    // delete form notFinishedMissions
    [self.dayController.notFinishedMissions removeObject:mission];
    self.dayController.notFinishedCount = [self.dayController.notFinishedMissions count];
    // delete from table view
    [self.dayController.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.missionController.navigationController popViewControllerAnimated:YES];
}

- (void)startTimer {
    [self.missionController performSegueWithIdentifier:@"Timer" sender:self];
}

- (void)updateCellByMission:(Mission *)mission {
    // Update the list controller.
    NSInteger section = 0;
    NSInteger row = [self.dayController.missionArray indexOfObject:mission];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self updateCellByIndexPath:indexPath];
}

- (void)saveDescribtion {
    self.missionController.currentMission.describtion = self.missionController.describtionTextView.text;
    [_dataCenter save];
}

- (void)stepperPlusOneByTag:(NSInteger)stepperTag {
    // * Get the info.
    NSString *stepperStr;
    switch (stepperTag) {
        case kStepperCurrent:
            stepperStr = @"current";
            break;
        case kStepperTarget:
            stepperStr = @"target";
            break;
        case kStepperInterrupt:
            stepperStr = @"interrupt";
            break;
        default:
            return;
            break;
    }
    NSString *stepperName = [NSString stringWithFormat:@"%@Stepper", stepperStr];
    NSString *labelName = [NSString stringWithFormat:@"%@Label", stepperStr];
    NSString *countName = [NSString stringWithFormat:@"%@Count", stepperStr];
    
    // * Get stepper and label from the above info.
    UIStepper *stepper = (UIStepper*)[self.missionController valueForKey:stepperName];
    UILabel *label = (UILabel*)[self.missionController valueForKey:labelName];
    
    // Set stepper.
    stepper.value = stepper.value + 1;
    // Set label.
    label.text = [NSString stringWithFormat:@"%d", (int)stepper.value];
    // Save change.
    [self.missionController.currentMission setValue:[NSNumber numberWithDouble:stepper.value] forKey:countName];
    [_dataCenter save];
    
    if (stepperTag == kStepperCurrent) {
        [self updateCurrentCountCell];
    }
}

- (void)updateCellByIndexPath:(NSIndexPath *)indexPath {
    // * Update the list controller.
    [self.dayController.tableView beginUpdates];
    [self.dayController.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.dayController.tableView endUpdates];
}

- (void)updateCurrentCountCell {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self updateCellByIndexPath:indexPath];
}

@end
