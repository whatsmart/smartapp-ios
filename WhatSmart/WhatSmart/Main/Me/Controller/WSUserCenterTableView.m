//
//  WSUserCenterTableView.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSUserCenterTableView.h"

#import "WSNormalTableViewCell.h"
#import "WSDataCenter.h"
#import "MBProgressHUD+WS.h"
#import "MJRefresh.h"
#import "WSSettingViewController.h"
#import "WSSettingGateway.h"


typedef NS_ENUM(NSUInteger, UserCenterSection) {
    UserCenterSectionOne = 0,
    UserCenterSectionTwo,
    UserCenterSectionThree,
};

@interface WSUserCenterTableView () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) UIView *footerView;

@end

@implementation WSUserCenterTableView

static NSInteger const rowHeightDefault = 44;
static NSString *const reuseIdentifier = @"userCenterCell";
static NSString *const myBindPhone = @"绑定手机";
static NSString *const mySetting = @"设置";
static NSString *const iconKey = @"icon";
static NSString *const titleKey = @"title";

#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        self.sectionHeaderHeight = 5;
        self.sectionFooterHeight = 5;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        
        self.backgroundColor = RGBColor(236, 236, 236);
        
        UIView *headFootTmpView = [UIView new];
        headFootTmpView.frame = CGRectMake(0, 0, 0, 10);
        self.tableHeaderView = headFootTmpView;
        self.tableFooterView = headFootTmpView;
        
        [self registerClass:[WSNormalTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        
        [self registNotification];
    }
    return self;
}

#pragma mark - 刷新数据
- (void)reloadDataArray {

    if ([self.header isRefreshing]) {
        [self.header endRefreshing];
    }
    
    if ([WSDataCenter shareDataCenter].currentUser.loginType == UserLoginTypeLogout) {

        [self reloadData];
    }else {
    }
}

#pragma mark - tableViewDelegate&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return rowHeightDefault;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WSNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];

    cell.imageView.image = [UIImage imageNamed:@""];
    cell.textLabel.text = @"修改网关";
    cell.textLabel.textColor = RGBColor(0x4c, 0x4c, 0x4c);
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@""];
        cell.textLabel.text = @"设置";
        cell.textLabel.textColor = RGBColor(0x4c, 0x4c, 0x4c);
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView;
    if (!self.footerView) {
        footerView = [[UIView alloc] init];
    }else {
        footerView = self.footerView;
    }
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        WSSettingGateway * gatewayVC = [[WSSettingGateway alloc] init];
        gatewayVC.hidesBottomBarWhenPushed = YES;
        [APPLICATION_DELEGATE.rootNavController pushViewController:gatewayVC animated:YES];
    }
    if (indexPath.row == 1) {
        WSSettingViewController * setVc = [[WSSettingViewController alloc] init];
        setVc.hidesBottomBarWhenPushed = YES;
        [APPLICATION_DELEGATE.rootNavController pushViewController:setVc animated:YES];
    }
    
}

#pragma mark - 通知相关
- (void)registNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateRefreshed) name:LoginStateRefreshed object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LoginStateRefreshed object:nil];
}

- (void)dealloc {
    [self removeNotification];
}

#pragma mark - 登录状态改变，刷新数据
- (void)loginStateRefreshed {
    //此处刷新列表的目的是不同用户的封禁状态不同，列表显示项不同
    [self reloadData];
}

@end
