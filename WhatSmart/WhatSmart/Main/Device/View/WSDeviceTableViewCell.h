//
//  WSDeviceTableViewCell.h
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSDeviceCellModel.h"

@interface WSDeviceTableViewCell : UITableViewCell
@property (nonatomic,strong) WSDeviceCellModel * model;
- (CGFloat )height;
@end
