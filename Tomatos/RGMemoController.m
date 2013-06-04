//
//  RGMemoController.m
//  Tomatos
//
//  Created by Zero on 13-4-16.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGMemoController.h"
#import <QuartzCore/QuartzCore.h>
#import "RGDataCenter.h"
#import "RGConstant.h"
#import "RGMemoMediator.h"

@interface RGMemoController () {
    RGDataCenter *_dataCenter;
}

@end

@implementation RGMemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set up data center and mediator
    _dataCenter = [RGDataCenter sharedDataCenter];
    _memoMediator.memoController = self;
    _memoMediator.listController = (RGMemoListController *)self.listController;
    
    // set up text view
    [self.memoTextView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    self.memoTextView.layer.borderWidth = 1.5;
    self.memoTextView.layer.cornerRadius = 15;
    
    // cancel default back button
    self.navigationItem.backBarButtonItem = nil;
    
    if (self.actionTag == kActionTagAdd) {
        // set up the left button
        self.navigationItem.leftBarButtonItem.title = @"取消";
        
        // set up the right button
        self.rightTopButton.title = @"添加";
        self.rightTopButton.tag = kActionTagAdd;
    }
    if (self.actionTag == kActionTagEdit) {
        // set up the text view
        self.memoTextView.text = self.currentMemo.info;
        //set up the left button
        self.navigationItem.leftBarButtonItem.title = @"保存并返回";
        self.navigationItem.leftBarButtonItem.tag = kActionTagEdit;
        // set up the right button
        self.rightTopButton.title = @"删除";
        self.rightTopButton.tag = kActionTagDelete;
        UIColor *itemColor = [UIColor colorWithRed:0.7 green:0 blue:0 alpha:1.0];
        self.rightTopButton.tintColor = itemColor;
    }
    
    // add tapper to dismiss keyboard
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tapper setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapper];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - private

- (void)dismissKeyboard {
    if ([self.memoTextView isFirstResponder]) {
        // dismiss keybord
        [self.memoTextView resignFirstResponder];
    }
    
}

@end
