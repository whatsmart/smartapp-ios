//
//  MBProgressHUD+WS.h
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//
#import "MBProgressHUD.h"

@interface MBProgressHUD (WS)

/**显示一条纯文本消息*/
+ (void)showStringMessage:(NSString *)message onView:(UIView *)view;

/**在window上显示一条纯文本消息*/
+ (void)showMessage:(NSString *)message;

@end
