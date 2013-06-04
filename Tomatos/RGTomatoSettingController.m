//
//  RGTomatoSettingController.m
//  Tomatos
//
//  Created by Zero on 13-4-1.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGTomatoSettingController.h"

@interface RGTomatoSettingController ()

@end

@implementation RGTomatoSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get tomato min from NSUserDefaults.
    NSInteger tMin = [[NSUserDefaults standardUserDefaults] integerForKey:@"tomatoMin"];
    // * No-exist situation.
    if (tMin == 0) {
        // Read the default settings from the plist.
        NSString *settingFile = [[NSBundle mainBundle] pathForResource:@"setting" ofType:@"plist"];
        NSDictionary *settingDict = [NSDictionary dictionaryWithContentsOfFile:settingFile];
        tMin = [[settingDict objectForKey:@"tomatoMin"] integerValue];
        // Set it.
        [[NSUserDefaults standardUserDefaults] setInteger:self.tomatoMin forKey:@"tomatoMin"];
    }
    
    self.tomatoMin = tMin;
    // Set up UI content.
    self.minStepper.value = (double)self.tomatoMin;
    self.minLabel.text = [NSString stringWithFormat:@"%d（分钟）", self.tomatoMin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (IBAction)minStep:(UIStepper *)sender {
    int stepperValue = (int)sender.value;
    self.tomatoMin = stepperValue;
    self.minLabel.text = [NSString stringWithFormat:@"%d（分钟）", stepperValue];
}

- (IBAction)edit:(id)sender {
    // Config the user defaults.
    [[NSUserDefaults standardUserDefaults] setInteger:self.tomatoMin forKey:@"tomatoMin"];
    [[self navigationController] popViewControllerAnimated:YES];
}
@end
