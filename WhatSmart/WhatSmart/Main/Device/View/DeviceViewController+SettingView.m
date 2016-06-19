//
//  DeviceViewController+SettingView.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "DeviceViewController.h"
#import "MBProgressHUD+WS.h"

@implementation DeviceViewController (SettingView)

-(void) createLightSettingViewWithModel:(DeviceModel*)model
{
    _lightSetView = [[UIView alloc] initWithFrame:kScreenFrame];
    [_lightSetView setBackgroundColor:UIColorFromHexA(0x0, .8)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_tap:)];
    tap.cancelsTouchesInView = YES;
    [_lightSetView addGestureRecognizer:tap];
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(30, 200, kScreenW-60, 380)];
    [backView.layer setCornerRadius:5];
    [backView setBackgroundColor:[UIColor whiteColor]];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_tapTop:)];
    tap2.cancelsTouchesInView = YES;
    backView.userInteractionEnabled = YES;
    [backView addGestureRecognizer:tap2];
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
    BOOL isOpen = [model.state.power isEqualToString:@"on"];
    UISwitch * powerSwith = [[UISwitch alloc] initWithFrame:CGRectMake(backView.width-20-60, powerLabel.top, 60, 20)];
    [powerSwith setOnTintColor:WSColor];
    [powerSwith setOn:isOpen];
    [backView addSubview:powerSwith];
    
    UILabel * lightLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, powerLabel.bottom+ 40, 40, 20)];
    [lightLabel setBackgroundColor:[UIColor clearColor]];
    [lightLabel setTextColor:[UIColor grayColor]];
    [lightLabel setFont:[UIFont systemFontOfSize:15]];
    [lightLabel setTextAlignment:NSTextAlignmentLeft];
    [lightLabel setText:@"亮度"];
    [backView addSubview:lightLabel];
    
    NSInteger light = model.state.brightness.integerValue;
    _lightSlider = [[UISlider alloc] initWithFrame:CGRectMake(lightLabel.right+20, lightLabel.top, powerSwith.right-(lightLabel.right+20), 10)];
    [_lightSlider setTintColor:WSColor];
    [_lightSlider setThumbTintColor:WSColor];
    [_lightSlider setMinimumValue:1];
    [_lightSlider setMaximumValue:100];
    _lightSlider.centerY = lightLabel.centerY;
    _lightSlider.value = light;
#warning 图片
    [_lightSlider setThumbImage:[UIImage imageNamed:@"grag_blue"] forState:UIControlStateNormal];
    [backView addSubview:_lightSlider];
    
    UILabel * colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(lightLabel.left, lightLabel.bottom+ 40, 40, 20)];
    [colorLabel setBackgroundColor:[UIColor clearColor]];
    [colorLabel setTextColor:[UIColor grayColor]];
    [colorLabel setFont:[UIFont systemFontOfSize:15]];
    [colorLabel setTextAlignment:NSTextAlignmentLeft];
    [colorLabel setText:@"颜色"];
    [backView addSubview:colorLabel];
    
    UISlider * colorSlider = [[UISlider alloc] initWithFrame:CGRectMake(_lightSlider.left, colorLabel.top, _lightSlider.width-30, 10)];
    [colorSlider setTintColor:WSColor];
    [colorSlider setThumbTintColor:WSColor];
    [colorSlider setMinimumValue:1];
    [colorSlider setMaximumValue:7];
    colorSlider.centerY = colorLabel.centerY;
#warning 图片
    [colorSlider setThumbImage:[UIImage imageNamed:@"grag_blue"] forState:UIControlStateNormal];
    [colorSlider addTarget:self action:@selector(colorSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [backView addSubview:colorSlider];
    
    _colorBtn = [[UIButton alloc] initWithFrame:CGRectMake(colorSlider.right+5, colorSlider.top, 30, 30)];
    [_colorBtn addTarget:self action:@selector(colorBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _colorBtn.layer.cornerRadius = 5.0;
    _colorBtn.centerY = colorSlider.centerY;
    [backView addSubview:_colorBtn];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(10, colorSlider.bottom+30, backView.width-20, 1)];
    [line setBackgroundColor:UIColorFromHex(0xf0f0f0)];
    [backView addSubview:line];
    
    UIButton * okBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, line.bottom+30, backView.width-100, 40)];
    [okBtn setBackgroundColor:WSColor];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn.layer setCornerRadius:10];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    __weak __typeof(&*self)weakSelf = self;
    __weak __typeof(UISwitch*)weakPowerSwitch = powerSwith;
    __weak __typeof(UISlider*)weakBrightnessSlider = _lightSlider;
    __weak __typeof(UISlider*)weakColorSlider = colorSlider;
    [okBtn addActionHandler:^(NSInteger tag) {
        DLog(@"点击确定");
        NSString * powerStr = weakPowerSwitch.isOn ? @"on":@"off";
        NSNumber* color = [weakSelf.colorArr objectAtIndex:weakColorSlider.value-1];
        NSString *colorStr = [NSString stringWithFormat:@"0x%0lx",(long)color.integerValue];
        
        [[WSDataCenter shareDataCenter] SetControlStateWithId:model.deviceId andState:@{@"power":powerStr,@"brightness":@((int)weakBrightnessSlider.value),@"color":colorStr}  Completion:^(BOOL isSuccess, NSString* des) {
            if (isSuccess) {
                [MBProgressHUD showMessage:@"设置成功"];
            }else{
                [MBProgressHUD showMessage:des];
            }
        }];
    }];
    [backView addSubview:okBtn];
    
    
    [self.view addSubview:_lightSetView];
    
}

-(void)colorBtnAction:(UIButton*)btn
{
    __weak typeof(self) weakSelf = self;
    id changeColorBlock = ^(UIColor *color){
        typeof(self) strongSelf = weakSelf;
        [strongSelf.colorBtn setBackgroundColor:color];
        [strongSelf.pickerView setHidden:YES];
    };
    if (self.pickerView) {
        [_lightSetView bringSubviewToFront:self.pickerView];
        [self.pickerView setHidden: NO];

    }else{
        self.pickerView = [[NKOColorPickerView alloc] initWithFrame:CGRectMake(0, 100, kScreenW, 200)];
        [self.pickerView setDidChangeColorBlock:changeColorBlock];
        [self.pickerView setColor:[UIColor colorWithRed:0.329f green:0.718f blue:1.f alpha:1.f]];
        [self.pickerView setTintColor:[UIColor darkGrayColor]];
        
        [_lightSetView addSubview:self.pickerView];
        [_lightSetView bringSubviewToFront:self.pickerView];
    }
    
}

-(void) colorSliderValueChanged:(UISlider*) slider
{
    NSInteger index = (NSInteger)slider.value -1;
    _colorBtn.backgroundColor = UIColorFromHex([[_colorArr objectAtIndex:index] integerValue]);
}
-(void)p_tap:(UITapGestureRecognizer*)tap
{
    DLog(@"tap");
    self.pickerView = nil;
    [_lightSetView removeAllSubviews];
    [_lightSetView removeFromSuperview];
    _lightSetView = nil;
}
-(void)p_tapTop:(UITapGestureRecognizer*)tap
{
    DLog(@"taptop");
}

@end
