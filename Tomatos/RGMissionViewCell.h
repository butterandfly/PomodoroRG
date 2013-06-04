//
//  RGMissionViewCell.h
//  TomatoApp
//
//  Created by Zero on 13-3-24.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import <UIKit/UIKit.h>

// RGMissionViewCell present the cell in the RGTodayTableViewControll.
@interface RGMissionViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *describtionLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishedLabel;
@end
