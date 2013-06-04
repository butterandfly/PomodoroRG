//
//  RGMemoMediator.h
//  Tomatos
//
//  Created by Zero on 13-4-17.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGMemoListController.h"

@class RGMemoController;
@class RGMemoListController;

// RGMemoMediator helps to manage the action of RGMemoController's UI.
@interface RGMemoMediator : NSObject

// Weak reference to memoController and listController.
@property (weak, nonatomic) RGMemoController* memoController;
@property (weak, nonatomic) RGMemoListController* listController;

// Action of nav bar's left button.
- (IBAction)leftTopClick:(id)sender;
// Action of nav bar's right button.
- (IBAction)rightTopClick:(id)sender;


@end
