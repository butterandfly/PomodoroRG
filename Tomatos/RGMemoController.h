//
//  RGMemoController.h
//  Tomatos
//
//  Created by Zero on 13-4-16.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGMemoMediator.h"
#import "Memo.h"

@interface RGMemoController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightTopButton;
@property (strong, nonatomic) IBOutlet RGMemoMediator *memoMediator;

@property (assign, nonatomic) NSInteger actionTag;
@property (weak, nonatomic) UIViewController *listController;
@property (strong, nonatomic) Memo *currentMemo;

@end
