//
//  UserCenterFatherViewController.h
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MBProgressHUD.h"
#import "UIViewAdditions.h"

@interface UserCenterFatherViewController : UIViewController <MBProgressHUDDelegate>

@property (strong, nonatomic) MBProgressHUD *progressHUD;
/**是否是黑色返回箭头*/
@property (assign, nonatomic) BOOL backBlackArrow;
/**导航栏背景色，*/
@property (weak, nonatomic) UIColor *topBarBgColor;
/**标题颜色，默认白色*/
@property (weak, nonatomic) UIColor *titleColor;

- (void)creatTopBar;

- (void)creatNavBackButton;

- (void)showToastMessage:(NSString*)message;

- (void)showNotice:(NSString*)notice withNoticeMode:(MBProgressHUDMode)noticeMode autoHide:(BOOL)autoHide;

- (void)removeNotice;

@end
