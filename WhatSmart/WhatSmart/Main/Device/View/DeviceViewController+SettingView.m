//
//  DeviceViewController+SettingView.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "DeviceViewController.h"

@implementation DeviceViewController (SettingView)

-(void) createLightSettingViewWithModel:(DeviceModel*)model
{
    _lightSetView = [[UIView alloc] initWithFrame:kScreenFrame];
    [_lightSetView setBackgroundColor:UIColorFromHexA(0x0, .8)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_tap:)];
    [_lightSetView addGestureRecognizer:tap];
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(30, 200, kScreenW-60, 300)];
    [backView.layer setCornerRadius:5];
    [backView setBackgroundColor:[UIColor whiteColor]];
    [_lightSetView addSubview:backView];
    
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backView.width, 40)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setTextColor:[UIColor blackColor]];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [nameLabel setText:@"灯光控制"];
    [backView addSubview:nameLabel];
    
    UILabel * powerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, nameLabel.bottom+50, 60, 20)];
    [powerLabel setBackgroundColor:[UIColor clearColor]];
    [powerLabel setTextColor:[UIColor grayColor]];
    [powerLabel setFont:[UIFont systemFontOfSize:15]];
    [powerLabel setTextAlignment:NSTextAlignmentLeft];
    [powerLabel setText:@"电源"];
    
    [backView addSubview:powerLabel];
    
    UISwitch * powerSwith = [[UISwitch alloc] initWithFrame:CGRectMake(backView.width-20-60, powerLabel.top, 60, 20)];
    [powerSwith setOnTintColor:WSColor];
    [powerSwith setOn:YES];
    [backView addSubview:powerSwith];
    
    UILabel * lightLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, powerLabel.bottom+ 40, 40, 20)];
    [lightLabel setBackgroundColor:[UIColor clearColor]];
    [lightLabel setTextColor:[UIColor grayColor]];
    [lightLabel setFont:[UIFont systemFontOfSize:15]];
    [lightLabel setTextAlignment:NSTextAlignmentLeft];
    [lightLabel setText:@"亮度"];
    [backView addSubview:lightLabel];
    
    UISlider * lightSlider = [[UISlider alloc] initWithFrame:CGRectMake(lightLabel.right+20, lightLabel.top, powerSwith.right-(lightLabel.right+20), 10)];
    [lightSlider setTintColor:WSColor];
    [lightSlider setThumbTintColor:WSColor];
    [lightSlider setMinimumValue:1];
    [lightSlider setMaximumValue:10];
    lightSlider.centerY = lightLabel.centerY;
#warning 图片
    [lightSlider setThumbImage:[UIImage imageNamed:@"grag_blue"] forState:UIControlStateNormal];
    [backView addSubview:lightSlider];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(10, lightSlider.bottom+30, backView.width-20, 1)];
    [line setBackgroundColor:UIColorFromHex(0xf0f0f0)];
    [backView addSubview:line];
    
    UIButton * okBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, line.bottom+30, backView.width-100, 40)];
    [okBtn setBackgroundColor:WSColor];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn.layer setCornerRadius:10];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn addActionHandler:^(NSInteger tag) {
        DLog(@"点击确定");
        
    }];
    [backView addSubview:okBtn];
    
    
    [self.view addSubview:_lightSetView];
    
}

-(void)p_tap:(UITapGestureRecognizer*)tap
{
    [_lightSetView removeFromSuperview];
    _lightSetView = nil;
}
@end
