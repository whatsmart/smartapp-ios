//
//  DeviceTableView.h
//  WhatSmart
//
//  Created by 董力云 on 16/4/19.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSTableView.h"

@interface DeviceTableView : WSTableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray * DeviceArray;

@end
