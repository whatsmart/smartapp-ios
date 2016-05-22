//
//  DeviceTableView.h
//  WhatSmart
//
//  Created by 董力云 on 16/4/19.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSTableView.h"
#import "DeviceViewController.h"

@interface DeviceTableView : WSTableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray * deviceArray;
@property (nonatomic,strong) DeviceViewController* fatherVC;
@end
