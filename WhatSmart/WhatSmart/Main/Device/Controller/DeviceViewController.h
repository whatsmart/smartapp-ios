//
//  DeviceViewController.h
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSViewController.h"
#import "DeviceModel.h"

@interface DeviceViewController : WSViewController
{
    __strong UIView * _lightSetView;
}
@end

@interface DeviceViewController (SettingView)

-(void) createLightSettingViewWithModel:(DeviceModel*)model;

@end
