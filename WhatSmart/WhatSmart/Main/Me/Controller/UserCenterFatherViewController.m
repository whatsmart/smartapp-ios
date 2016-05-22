//
//  UserCenterFatherViewController.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//
#import "UserCenterFatherViewController.h"
@interface UserCenterFatherViewController ()
{
    UILabel * _titleLabel;
    UIButton * _leftBarButton;
    UIImageView * _topNavBarImageView;
}
@end

@implementation UserCenterFatherViewController


- (void)showToastMessage:(NSString*)message  {
    MBProgressHUD* tmpHUD = [[MBProgressHUD alloc] initWithView:self.view];
    tmpHUD.userInteractionEnabled = NO;
    [self.view addSubview:tmpHUD];
    [self.view bringSubviewToFront:tmpHUD];
    tmpHUD.mode = MBProgressHUDModeText;
    tmpHUD.delegate = self;
    tmpHUD.labelText = message;
    [tmpHUD show:YES];
    [tmpHUD hide:YES afterDelay:1.5];
    tmpHUD.removeFromSuperViewOnHide=YES;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.wantsFullScreenLayout = YES;
        if (SYSTEM_VERSION_NEWER_OR_EQUAL_TO_7) {
            self.automaticallyAdjustsScrollViewInsets = NO;
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    return self;
}

- (void)creatTopBar{
    [self.navigationController setNavigationBarHidden:YES];
    if (_topNavBarImageView) {
        [_topNavBarImageView removeFromSuperview];
        _topNavBarImageView = nil;
        [_titleLabel removeFromSuperview];
        _titleLabel = nil;
    }
    _topNavBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    DLog(@"frame: %@",NSStringFromCGRect(_topNavBarImageView.frame) );
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, _topNavBarImageView.frame.size.width, 44)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = self.title;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_topNavBarImageView addSubview:_titleLabel];
    
    if (self.topBarBgColor) {
        _topNavBarImageView.backgroundColor = self.topBarBgColor;
    }else {
        _topNavBarImageView.backgroundColor = WSColor;
    }
    
    _topNavBarImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    if (_leftBarButton) {
        [self.view insertSubview:_topNavBarImageView belowSubview:_leftBarButton];
    }else{
        [self.view addSubview:_topNavBarImageView];
    }
}

- (void)setTopBarBgColor:(UIColor *)topBarBgColor {
    _topBarBgColor = topBarBgColor;
    _topNavBarImageView.backgroundColor = topBarBgColor;
}

- (void)setBackBlackArrow:(BOOL)backBlackArrow {
    _backBlackArrow = backBlackArrow;
    if (backBlackArrow == YES) {
        [_leftBarButton setImage:[UIImage imageNamed:@"returnArrowBtn_black"] forState:UIControlStateNormal];
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    _titleLabel.text = title;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _titleLabel.text = self.title;
}

- (void)creatNavBackButton {
    if (_leftBarButton) {
        [_leftBarButton removeFromSuperview];
        _leftBarButton = nil;
    }
    _leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBarButton.frame = CGRectMake(8, 25, 44, 34);
    _leftBarButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    [_leftBarButton setImage:[UIImage imageNamed:@"returnArrowBtn.png"] forState:UIControlStateNormal];
    [_leftBarButton addTarget:self action:@selector(leftBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftBarButton];
}

- (void)leftBackBtnClicked:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate {
    return NO;
}

/**
 *  弹出通知
 *
 *  @param notice     通知内容
 *  @param noticeMode 通知展示形式
 *  @param autoHide   是否自动隐藏
 */
- (void)showNotice:(NSString*)notice withNoticeMode:(MBProgressHUDMode)noticeMode autoHide:(BOOL)autoHide {
    
    if (self.progressHUD) {
        [self.progressHUD removeFromSuperview];
        self.progressHUD = nil;
    }
    
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.progressHUD setUserInteractionEnabled:NO];
    if (notice==nil) {
        [self.progressHUD setMode:MBProgressHUDModeText];
    }else{
        [self.progressHUD setMode:noticeMode];
    }
    [self.progressHUD setDelegate:self];
    [self.progressHUD setLabelText:notice];
    [self.progressHUD show:YES];
    if (autoHide) {
        [self.progressHUD hide:YES afterDelay:1.5];
        [self.progressHUD setRemoveFromSuperViewOnHide:YES];
    }
    [self.view addSubview:self.progressHUD];
    [self.view bringSubviewToFront:self.progressHUD];
}

/**
 *  移除通知
 */
- (void)removeNotice {
    if (self.progressHUD) {
        [self.progressHUD hide:YES];
        [self.progressHUD setRemoveFromSuperViewOnHide:YES];
        self.progressHUD = nil;
    }
}
@end
