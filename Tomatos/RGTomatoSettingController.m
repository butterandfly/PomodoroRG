//
//  RGTomatoSettingController.m
//  Tomatos
//
//  Created by Zero on 13-4-1.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGTomatoSettingController.h"
#import "RGAppUserDefaults.h"

@interface RGTomatoSettingController ()

@end

@implementation RGTomatoSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tomatoMin = [RGAppUserDefaults tomatoTime];
    // Set up UI content.
    self.minStepper.value = (double)self.tomatoMin;
    self.minLabel.text = [NSString stringWithFormat:NSLocalizedString(@"MINUTE", nil), self.tomatoMin];
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
    [RGAppUserDefaults setTomatoTime:self.tomatoMin];
    [[self navigationController] popViewControllerAnimated:YES];
}
@end
