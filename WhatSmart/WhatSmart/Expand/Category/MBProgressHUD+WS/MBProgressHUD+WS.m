//
//  MBProgressHUD+WS.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//


#import "MBProgressHUD+WS.h"

@implementation MBProgressHUD (WS)

/**根据传入的view显示一条纯文本消息*/
+ (void)showStringMessage:(NSString *)message onView:(UIView *)view {
    if (!view) return;
    MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:view];
    hud.userInteractionEnabled = NO;
    [view addSubview:hud];
    [view bringSubviewToFront:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    [hud show:YES];
    [hud hide:YES afterDelay:1.5];
    hud.removeFromSuperViewOnHide = YES;
}

/**在window上显示一条纯文本消息*/
+ (void)showMessage:(NSString *)message {
    [MBProgressHUD showStringMessage:message onView:[UIApplication sharedApplication].keyWindow];
}

@end
