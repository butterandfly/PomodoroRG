//
//  RGTimerController.m
//  Tomatos
//
//  Created by Zero on 13-3-31.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGTimerController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>

#define SEC_PER_MIN 60

@interface RGTimerController () {
    NSDate *_startDate;
    // _tomatoTime is the summer seconds in a tomato.
    NSTimeInterval _tomatoTime;
    BOOL _isRunning;
    AVAudioPlayer *_musicPlayer;
}

@property (strong) NSTimer *timer;

- (void)timerFire:(NSTimer *)timer;
- (void)sendNotificationWithDate:(NSDate *)fireDate;
- (void)timeUp;
- (void)becomeActive;
- (void)resignActive;
- (void)buildTimer;
- (void)cancelTimer;
- (void)setupTimeLabel:(double)timeInfo;
- (void)start;
- (void)releaseAllStuff;

@end

@implementation RGTimerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get tomata time in NSUserDefaults.
    NSInteger tMin = [[NSUserDefaults standardUserDefaults] integerForKey:@"tomatoMin"];
    // * Situation of first time running.
    if (tMin == 0) {
        // Get init settings from plist.
        NSString *settingFile = [[NSBundle mainBundle] pathForResource:@"setting" ofType:@"plist"];
        NSDictionary *settingDict = [NSDictionary dictionaryWithContentsOfFile:settingFile];
        tMin = [[settingDict objectForKey:@"tomatoMin"] integerValue];
        // Set setting to NSUserDefaults.
        [[NSUserDefaults standardUserDefaults] setInteger:self.tomatoMin forKey:@"tomatoMin"];
    }
    
    [self setupTomatoMin:tMin];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    // music thing
    NSURL *musicUrl = [[NSBundle mainBundle] URLForResource:@"alarm2" withExtension:@"mp3"];
    _musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
    [_musicPlayer setVolume:1.0];
    
    // start
    [self start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

#pragma mark - action methods

// Action button.
- (IBAction)action:(id)sender {
    // Default to stop the tomato.
    if (_isRunning) {
        // Interrupt this tomato, release all stuff.
        _isRunning = NO;
        [self releaseAllStuff];
        // Update mission controller.
        // Set missionDelegate's interrupt count.
        [self.missionDelegate.missionMediator stepperPlusOneByTag:kStepperInterrupt];
        // Dismiss this controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)cancel:(id)sender {
    [self releaseAllStuff];
    // Dismiss.
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupTomatoMin:(double)tMin {
    // Set up the _tomatoTime.
    self.tomatoMin = tMin;
    _tomatoTime = tMin * SEC_PER_MIN;
    // Set up the time label.
    [self setupTimeLabel:_tomatoTime];
}

#pragma mark - Private methods

- (void)start {
    _startDate = [NSDate date];
    [self setupTimeLabel:_tomatoTime];
    NSDate *fireDate = [_startDate dateByAddingTimeInterval:_tomatoTime];
    [self sendNotificationWithDate:fireDate];
    [self buildTimer];
    _isRunning = YES;
}

- (void)cancelTimer {
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

// Create a timer.
- (void)buildTimer {
    // Set "timerFire" to check timing up.
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

// Check timing up.
- (void)timerFire:(NSTimer *)timer {
    NSDate *now = [NSDate date];
    NSTimeInterval stillHave = _tomatoTime - [now timeIntervalSinceDate:_startDate];
    // When time up.
    // May be we should use "0" here, but "-0.5" is a more better.
    if (stillHave < -0.5) {
        // * Time up!
        [self cancelTimer];
        if (_isRunning) {
            _isRunning = NO;
            [self timeUp];
        }
    } else {
        // Set up the time label.
        [self setupTimeLabel:stillHave];
    }
}


// This function helps to set up the time label, need the second.
- (void)setupTimeLabel:(double)timeInfo {
    NSInteger intTime = round(timeInfo);
    NSString *timeString = [NSString stringWithFormat:@"%02d:%02d", intTime/SEC_PER_MIN, intTime%SEC_PER_MIN];
    self.timeLabel.text = timeString;
}

// This functions helps to send the notification.
- (void)sendNotificationWithDate:(NSDate *)fireDate {
    // * Create a notifiction.
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = fireDate;
    notification.alertBody = @"完成一个番茄！";
    notification.alertAction = @"确定";
    notification.soundName = @"alarm2.mp3";
    
    // Schedule.
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)timeUp {
    // Force to show the 1st tab controller.
    [self.tabBarController setSelectedIndex:0];
    
    // Play music and vibrate the phone.
    [_musicPlayer play];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    // Show alert.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"时间到！" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

// When the app become active, this method will be execute.
// This method will executed before timerFire, when the app is becoming active.
- (void)becomeActive {
    if (_isRunning) {
        // Check timing up.
        NSDate *now = [NSDate date];
        NSTimeInterval stillHave = _tomatoTime - [now timeIntervalSinceDate:_startDate];
        // * Timeing up situation.
        if (stillHave < 0) {
            // Change to the 1st tab controller.
            [self.tabBarController setSelectedIndex:0];
            // Cancel timer.
            [self cancelTimer];
            // Set up running state and the time label.
            _isRunning = NO;
            self.timeLabel.text = @"00:00";
            // Show alert.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"完成了一个番茄！" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        } else {
            // Set up the time label.
            [self setupTimeLabel:stillHave];
            // Rebuild the timer.
            [self buildTimer];
        }
    }
}

// When the app become inactive, this method will be execute.
- (void)resignActive {
    // Cancel the timer.
    [self cancelTimer];
}

- (void)releaseAllStuff {
    // Cancel timer.
    [self cancelTimer];
    // Cancel audio player.
    _musicPlayer = nil;
    // Cancel notification.
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // Remove observer.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // Stop muisc.
        [_musicPlayer stop];
        // Plus the current count from the mediator.
        [self.missionDelegate.missionMediator stepperPlusOneByTag:kStepperCurrent];
        // Pop the view.
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
