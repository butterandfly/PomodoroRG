//
//  RGMissionViewController.m
//  Tomatos
//
//  Created by Zero on 13-3-24.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGMissionViewController.h"
#import "Mission.h"
#import "RGConstant.h"
#import "RGMissionDataCenter.h"

@interface RGMissionViewController () {
}

- (void)commonInit;
- (void)initInCheckingMode;
- (void)initInEditingMode;
- (void)dismissKeyboard;

@end

@implementation RGMissionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Setup the mission mediator.
    // We do not need to create a new one.
    // The story board has created it.
    self.missionMediator.missionController = self;
    self.missionMediator.dayController = self.missionListDelegate;
    
    [self commonInit];
    
    if (self.actionMode == kActionTagCheck) {
        [self initInCheckingMode];
    }
    
    if (self.actionMode == kActionTagEdit) {
        [self initInEditingMode];
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
        [self.missionMediator startTimer];
    }
    if (indexPath.section == 6 && indexPath.row == 0) {
        [self.missionMediator deleteMission];
    }
}

#pragma mark - Text view delegate
/*
// Return button to dismiss the keyboard.
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
        [self.describtionTextView resignFirstResponder];
    }
    
}

- (void)initInCheckingMode {
    self.describtionTextView.editable = NO;
    
    if ([self.currentMission.isFinished boolValue]) {
        self.isFinishedLabel.textColor = [UIColor greenColor];
        self.isFinishedLabel.text = NSLocalizedString(@"DONETIP", nil);
    } else {
        self.isFinishedLabel.textColor = [UIColor redColor];
        self.isFinishedLabel.text = NSLocalizedString(@"NOTDONETIP", nil);
    }
}

- (void)initInEditingMode {
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

- (void)commonInit {
    // Set up the content.
    self.describtionTextView.text = self.currentMission.describtion;
    self.targetLabel.text = [self.currentMission.targetCount stringValue];
    self.currentLabel.text = [self.currentMission.currentCount stringValue];
    self.interruptLabel.text = [self.currentMission.interruptCount stringValue];
}

@end