//
//  DeviceViewController.h
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSViewController.h"
#import "DeviceModel.h"
#import "NKOColorPickerView.h"


@interface DeviceViewController : WSViewController
{
    __strong UIView * _lightSetView;
    __strong  UIButton * _colorBtn;
    __strong NSArray * _colorArr;
    __strong UISlider * _lightSlider;
}
@property (strong, nonatomic) UIButton * colorBtn;
@property (strong, nonatomic) NSArray * colorArr;
@property (strong, nonatomic)  NKOColorPickerView *pickerView;

@end


@interface DeviceViewController (SettingView)

-(void) createLightSettingViewWithModel:(DeviceModel*)model;

@end
