//
//  RGAddMissionViewController.h
//  Tomatos
//
//  Created by Zero on 13-3-25.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGTodayTableViewController.h"
#import "Mission.h"

@interface RGAddMissionViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextView *describtionTextView;
@property (weak, nonatomic) IBOutlet UILabel *targetLabel;
@property (weak, nonatomic) IBOutlet UIStepper *targetStepper;

@property (weak, nonatomic) RGTodayTableViewController *missionListDelegate;

- (IBAction)addMission:(id)sender;
- (IBAction)targetStep:(UIStepper *)sender;

@end
