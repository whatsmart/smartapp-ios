//
//  WSSettingViewController.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

//  设置 界面

#import "WSSettingViewController.h"
#import "WSNormalTableViewCell.h"
#import "WSDataCenter.h"
#import "UIButton+Block.h"
#import "WSAboutUsViewController.h"
#import "WSFeedBackViewController.h"

@interface WSSettingViewController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) UIButton *logoutButton;
@property (strong, nonatomic) NSArray *titleArray;

@end

@implementation WSSettingViewController

static NSString *const reuseIdentifier = @"settingCell";

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"关于我们",@"意见反馈",@"联系客服"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化界面
    [self setUpView];
}

#pragma mark - 初始化界面
- (void)setUpView {
    self.view.backgroundColor = RGBColor(236, 236, 236);
    [self creatTopBar];
    [self creatNavBackButton];
    self.title = @"设置";
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    tableView.backgroundColor = RGBColor(236, 236, 236);
    tableView.tableFooterView = [self logoutView];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(75);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [tableView registerClass:[WSNormalTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

#pragma mark - 创建退出登录View
- (UIView *)logoutView {
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = self.view.backgroundColor;
    bgView.frame = CGRectMake(0, 0, 0, 84);
    
    UIButton *logoutButton = [[UIButton alloc] init];
    logoutButton.backgroundColor = WSColor;
    logoutButton.layer.cornerRadius = 3;
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [bgView addSubview:logoutButton];
    self.logoutButton = logoutButton;
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(kScreenW - 40, 44));
    }];
    //退出登录点击
    __weak __typeof (&*self)weakSelf = self;
    [logoutButton addActionHandler:^(NSInteger tag) {
        [[WSDataCenter shareDataCenter] Logout:nil];
        weakSelf.logoutButton.hidden = YES;
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    return bgView;
}

#pragma mark - tableViewDelegate&&dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = RGBColor(0x4c, 0x4c, 0x4c);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            WSAboutUsViewController * aboutVC = [[WSAboutUsViewController alloc]init];
            [APPLICATION_DELEGATE.rootNavController pushViewController:aboutVC animated:YES];
        }
            break;
        case 1:
        {
            WSFeedBackViewController *feedBackVC = [[WSFeedBackViewController alloc] init];
            [APPLICATION_DELEGATE.rootNavController pushViewController:feedBackVC animated:YES];
        }
            break;
        case 2:
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"客服QQ" message:CUSTOMER_SERVICE_QQ delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"复制QQ", nil];
            alert.delegate = self;
            [alert show];
        }
            break;
        default:
            break;
    }
}

#pragma mark - alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UIPasteboard * borad = [UIPasteboard generalPasteboard];
        borad.string = CUSTOMER_SERVICE_QQ;
        [self showToastMessage:@"QQ号码已复制到剪切板"];
    }
}

#pragma mark - 判断是否显示退出按钮
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([WSDataCenter shareDataCenter].currentUser.loginType == UserLoginTypeLogout) {
        self.logoutButton.hidden = YES;
    }else{
        self.logoutButton.hidden = NO;
    }
}

#pragma mark - 统计相关
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

@end
