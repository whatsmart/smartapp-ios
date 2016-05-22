//
//  WSUserCenterViewController.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//

//  个人中心视图控制器

#import "WSUserCenterViewController.h"
#import "WSUserCenterHeadView.h"
#import "WSUserCenterTableView.h"
#import "WSDataCenter.h"

@interface WSUserCenterViewController ()

@property (weak, nonatomic) WSUserCenterHeadView *headView;
@property (weak, nonatomic) WSUserCenterTableView *tableView;

@end

@implementation WSUserCenterViewController

static NSString *const pageName = @"我的页面";

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化背景色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //初始化头部视图
    [self setUpHeadView];
    //初始化列表
    [self setUpTableView];
}

#pragma mark - 初始化头部视图
- (void)setUpHeadView {
    WSUserCenterHeadView *headView = [[WSUserCenterHeadView alloc] init];
    self.headView = headView;
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.top.equalTo(self.view);
        make.height.mas_equalTo(178);
    }];
}

#pragma mark - 初始化列表
- (void)setUpTableView {
    
    WSUserCenterTableView *tableView = [[WSUserCenterTableView alloc] init];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - 数据刷新处理
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //刷新界面数据
//    [FocusManager updateMyAnchorArray];
}

#pragma mark - 统计相关
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

@end
