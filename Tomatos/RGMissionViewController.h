//
//  RGMissionViewController.h
//  Tomatos
//
//  Created by Zero on 13-3-24.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGTodayTableViewController.h"
#import "Mission.h"
#import "RGMissionMediator.h"

typedef enum {
    kStepperCurrent,
    kStepperTarget,
    kStepperInterrupt
} StepperTag;

@interface RGMissionViewController : UITableViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet RGMissionMediator *missionMediator;
// comman
@property (weak, nonatomic) IBOutlet UITextView *describtionTextView;
@property (weak, nonatomic) IBOutlet UILabel *targetLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *interruptLabel;
// edit mission only
@property (weak, nonatomic) IBOutlet UISwitch *finishedSwitch;
@property (weak, nonatomic) IBOutlet UIStepper *currentStepper;
@property (weak, nonatomic) IBOutlet UIStepper *targetStepper;
@property (weak, nonatomic) IBOutlet UIStepper *interruptStepper;
// check mission only
@property (weak, nonatomic) IBOutlet UILabel *isFinishedLabel;

@property (weak, nonatomic) RGTodayTableViewController *missionListDelegate;
@property (strong, nonatomic) Mission *currentMission;
//@property (assign, nonatomic) BOOL isCheckOnly;
@property (assign, nonatomic) NSInteger actionMode;

// edit mission view only
//- (void)interruptPlusOne;
//- (void)currentPlusOne;

@end
