//
//  RGTimerController.h
//  Tomatos
//
//  Created by Zero on 13-3-31.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGMissionViewController.h"

// RGTimerController controls the veiw that shows the timer.
// This controller response the alert in it's view.
@interface RGTimerController : UIViewController <UIAlertViewDelegate>

// "timeLabel" shows the time that we have.
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
// "actionButton" is the center button.
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
// Minutes in a tomato.
@property (assign, nonatomic) NSInteger tomatoMin;
// A reference to the parent controller(missionController).
@property (weak, nonatomic) RGMissionViewController *missionDelegate;

// Click function of "actionButton".
- (IBAction)action:(id)sender;
// Click function of the back button in navigation.
- (IBAction)cancel:(id)sender;
// An setup function 4 "tomatoMin"
- (void)setupTomatoMin:(double)tMin;

@end
