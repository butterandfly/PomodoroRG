//
//  RGMissionViewController.m
//  Tomatos
//
//  Created by Zero on 13-3-24.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGMissionViewController.h"
#import "Mission.h"
#import "RGDataCenter.h"
#import "RGConstant.h"

@interface RGMissionViewController () {
    __weak RGDataCenter *_dataCenter;
}

- (void)dismissKeyboard;

@end

@implementation RGMissionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Get and set dataCenter.
    _dataCenter = [RGDataCenter sharedDataCenter];
    
    // Setup the mission mediator.
    // We do not need to create a new one.
    // The story board has created it.
    self.missionMediator.missionController = self;
    self.missionMediator.dayController = self.missionListDelegate;
    
    // Set up the content.
    self.describtionTextView.text = self.currentMission.describtion;
    self.targetLabel.text = [self.currentMission.targetCount stringValue];
    self.currentLabel.text = [self.currentMission.currentCount stringValue];
    self.interruptLabel.text = [self.currentMission.interruptCount stringValue];
    
    // * Check only mode.
    if (self.actionMode == kActionTagCheck) {
        // Disnable some compenent.
        self.describtionTextView.editable = NO;
        if ([self.currentMission.isFinished boolValue]) {
            self.isFinishedLabel.textColor = [UIColor greenColor];
            self.isFinishedLabel.text = @"该任务已完成";
        } else {
            self.isFinishedLabel.textColor = [UIColor redColor];
            self.isFinishedLabel.text = @"该任务未完成";
        }
    }
    // * Edit mode.
    if (self.actionMode == kActionTagEdit) {
        // Cancel the default "back" button.
        [self.navigationItem setHidesBackButton:YES];
        
        // Set tapper.
        UITapGestureRecognizer *taper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
        [taper setCancelsTouchesInView:NO];
        [self.view addGestureRecognizer:taper];
        
        // Set up the content.
        self.targetStepper.value = [self.currentMission.targetCount doubleValue];
        self.currentStepper.value = [self.currentMission.currentCount doubleValue];
        self.interruptStepper.value = [self.currentMission.interruptCount doubleValue];
        [self.finishedSwitch setOn:[self.currentMission.isFinished boolValue]];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *des = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"Timer"]) {
        [des setValue:self forKey:@"missionDelegate"];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        // start timer
        [self.missionMediator startTimer];
    }
    if (indexPath.section == 6 && indexPath.row == 0) {
        // delete mission
        [self.missionMediator deleteMission];
    }
}

#pragma mark - Text view delegate
/*
// Return to dismiss the keyboard.
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        //
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
 */

- (void)textViewDidEndEditing:(UITextView *)textView {
    // Save text.
    [self.missionMediator saveDescribtion];
    [self.missionMediator updateCellByMission:self.currentMission];
}

#pragma mark - private

- (void)dismissKeyboard {
    if ([self.describtionTextView isFirstResponder]) {
        // dismiss keybord
        [self.describtionTextView resignFirstResponder];
    }
    
}

@end