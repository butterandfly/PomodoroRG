//
//  RGAddMissionViewController.m
//  Tomatos
//
//  Created by Zero on 13-3-25.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGAddMissionViewController.h"
#import "RGDataCenter.h"
#import "Date.h"

@interface RGAddMissionViewController () {
    RGDataCenter *_dataCenter;
}

@end

@implementation RGAddMissionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataCenter = [RGDataCenter sharedDataCenter];
    
    
    UITapGestureRecognizer *taper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:taper];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (IBAction)targetStep:(UIStepper *)sender {
    //
    self.targetLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
}

- (IBAction)addMission:(id)sender {
    Mission *mission;
    Date *currentDay = self.missionListDelegate.currentDay;
    mission = [_dataCenter addMissionWithDesc:self.describtionTextView.text targetCount:[NSNumber numberWithDouble:self.targetStepper.value] InDate:currentDay];
    [self.missionListDelegate addMission:mission];
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


#pragma mark - private

- (void)dismissKeyboard {
    if ([self.describtionTextView isFirstResponder]) {
        [self.describtionTextView resignFirstResponder];
    }
    
}

@end
