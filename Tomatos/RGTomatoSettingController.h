//
//  RGTomatoSettingController.h
//  Tomatos
//
//  Created by Zero on 13-4-1.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGTimerController.h"

// RGTomatoSettingController let the user do some tomato setting.
@interface RGTomatoSettingController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UIStepper *minStepper;
@property (assign, nonatomic) NSInteger tomatoMin;
@property (weak) RGTimerController *tomatoController;

- (IBAction)minStep:(UIStepper *)sender;
// Right button of nav bar's action.
- (IBAction)edit:(id)sender;

@end
