//
//  WSUserCenterHeadView.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//
//  个人中心头部视图

#import "WSUserCenterHeadView.h"
#import "WSLoginViewController.h"
#import "WSDataCenter.h"
#import "UIButton+Block.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+WS.h"


@interface WSUserCenterHeadView () <UIAlertViewDelegate>

@property (weak, nonatomic) UIImageView *headImageView;
@property (weak, nonatomic) UIImageView *headIconImageView;
@property (weak, nonatomic) UIButton *loginButton;
@property (weak, nonatomic) UIButton *leftCoinButton;
@property (weak, nonatomic) UILabel *nickNameLabel;
@property (weak, nonatomic) UILabel *noLoginLabel;

@end

@implementation WSUserCenterHeadView

- (instancetype)init {
    if (self = [super init]) {
        [self setUpView];
        [self updateLoginState];
        [self p_registNotification];
    }
    return self;
}

#pragma mark - 初始化界面
- (void)setUpView {
    
    //背景
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.userInteractionEnabled = YES;
    headImageView.image = [UIImage imageNamed:@"userinfoBgImage"];
    [self addSubview:headImageView];
    self.headImageView = headImageView;
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //头像
    CGFloat headIconSize = 56;
    UIImageView *headIconImageView = [[UIImageView alloc] init];
    headIconImageView.layer.cornerRadius = headIconSize * 0.5;
    headIconImageView.layer.borderWidth = 2;
    headIconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headIconImageView.clipsToBounds = YES;
    headIconImageView.image = [UIImage imageNamed:@"defaultAvatar"];
    [headImageView addSubview:headIconImageView];
    self.headIconImageView = headIconImageView;
    [headIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImageView).offset(20 + 16);
        make.centerX.equalTo(headImageView);
        make.size.mas_equalTo(CGSizeMake(headIconSize, headIconSize));
    }];
    
    //昵称
    UILabel *nickNameLabel = [[UILabel alloc] init];
    nickNameLabel.font = [UIFont systemFontOfSize:12];
    nickNameLabel.textColor = [UIColor whiteColor];
    nickNameLabel.textAlignment = NSTextAlignmentCenter;
    nickNameLabel.text = @"登录/注册";
    [headImageView addSubview:nickNameLabel];
    self.nickNameLabel = nickNameLabel;
    [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headIconImageView.mas_bottom).offset(8);
        make.left.equalTo(headImageView).offset(20);
        make.right.equalTo(headImageView).offset(-20);
        make.height.mas_equalTo(15);
    }];
    if (!SYSTEM_VERSION_NEWER_OR_EQUAL_TO_7) {
        nickNameLabel.backgroundColor = [UIColor clearColor];
    }
    
    //登录按钮
    UIButton *loginButton = [[UIButton alloc] init];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    loginButton.backgroundColor = RGBColor(240, 240, 240);
    loginButton.layer.cornerRadius = 3;
    [loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:RGBColor(90, 90, 90) forState:UIControlStateNormal];
    loginButton.hidden = YES;
    [headImageView addSubview:loginButton];
    self.loginButton = loginButton;
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headImageView);
        make.size.mas_equalTo(CGSizeMake(109, 27));
    }];
    
    UILabel *noLoginLabel = [[UILabel alloc] init];
    noLoginLabel.text = @"亲！您还没有登录哦~";
    noLoginLabel.textAlignment = NSTextAlignmentCenter;
    noLoginLabel.textColor = RGBColor(245, 245, 245);
    noLoginLabel.font = [UIFont systemFontOfSize:13];
    noLoginLabel.hidden = YES;
    [headImageView addSubview:noLoginLabel];
    self.noLoginLabel = noLoginLabel;
    [noLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).offset(11);
        make.left.equalTo(headImageView).offset(20);
        make.right.equalTo(headImageView).offset(-20);
    }];
    if (!SYSTEM_VERSION_NEWER_OR_EQUAL_TO_7) {
        noLoginLabel.backgroundColor = [UIColor clearColor];
    }
    
//    UIView *buttonBgView = [[UIView alloc] init];
//    [self addSubview:buttonBgView];
//    [buttonBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(headImageView.mas_bottom);
//        make.left.right.bottom.equalTo(self);
//    }];
//    
//    UIView *middleLineView = [[UIView alloc] init];
//    middleLineView.backgroundColor = RGBColor(249, 249, 249);
//    [buttonBgView addSubview:middleLineView];
//    [middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.centerX.equalTo(buttonBgView);
//        make.width.mas_equalTo(1);
//    }];
//    
//    UIView *bottomLineView = [[UIView alloc] init];
//    bottomLineView.backgroundColor = RGBColor(0xe7, 0xe7, 0xe7);
//    [self addSubview:bottomLineView];
//    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(buttonBgView);
//        make.height.mas_equalTo(0.5);
//    }];
//    
    
}

#pragma mark - 登录状态改变
- (void)updateLoginState {
    
    if ([WSDataCenter shareDataCenter].currentUser.loginType != UserLoginTypeLogout) {//已登录
        self.headIconImageView.hidden = NO;
        self.nickNameLabel.hidden = NO;
        self.loginButton.hidden = YES;
        self.noLoginLabel.hidden =YES;
//        [self.headIconImageView sd_setImageWithURL:[NSURL URLWithString:[WSDataCenter shareDataCenter].currentUser.figureUrl] placeholderImage:[UIImage imageNamed:@"defaultAvatar.png"]];
        self.nickNameLabel.text = [WSDataCenter shareDataCenter].currentUser.name;
//        [[WSDataCenter shareDataCenter] updateCountInfo];
    }else{
        self.headIconImageView.hidden = YES;
        self.nickNameLabel.hidden = YES;
        self.loginButton.hidden = NO;
        self.noLoginLabel.hidden = NO;
    }
}

#pragma mark - 跳转登录
- (void)login
{
    
    if ([WSDataCenter shareDataCenter].currentUser.loginType == UserLoginTypeLogout) {
        WSLoginViewController * loginVC = [[WSLoginViewController alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        
        [APPLICATION_DELEGATE.rootNavController pushViewController:loginVC animated:YES];
    }
}

#pragma mark - 通知相关
- (void)p_updateUserInfo:(NSNotification*)noti{
    if ([WSDataCenter shareDataCenter].currentUser.loginType == UserLoginTypeLogout) {
//        [self.leftCoinButton setAttributedTitle:[self leftCoinAttributeStringWithCoin:@"0"] forState:UIControlStateNormal];
    }else{
//        [self.leftCoinButton setAttributedTitle:[self leftCoinAttributeStringWithCoin:[noti.userInfo valueForKey:@"money"]] forState:UIControlStateNormal];
    }
}

- (void)p_registNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLoginState) name:LoginStateRefreshed object:nil];
}

- (void)p_removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LoginStateRefreshed object:nil];
}

- (void)dealloc {
    [self p_removeNotification];
}

@end
