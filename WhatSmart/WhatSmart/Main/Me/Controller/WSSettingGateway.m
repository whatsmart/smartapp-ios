//
//  WSSettingGateway.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/29.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSSettingGateway.h"

@interface WSSettingGateway ()

@property (strong, nonatomic) UITextField* gatewayTextField;
@end

@implementation WSSettingGateway

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBColor(236, 236, 236);
    [self creatTopBar];
    [self creatNavBackButton];
    self.title = @"设置网关";
    
    [self setupView];
}

-(void)setupView
{
    _gatewayTextField  = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, kScreenW-40, 40)];
    _gatewayTextField.font = [UIFont systemFontOfSize:18];
    _gatewayTextField.placeholder = @"请输入IP地址或域名";
    _gatewayTextField.borderStyle = UITextBorderStyleRoundedRect;
    _gatewayTextField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_gatewayTextField];
    
    WSButton * setBtn = [[WSButton alloc] initWithFrame:CGRectMake(_gatewayTextField.left, _gatewayTextField.bottom+30, _gatewayTextField.width, 40)];
    [setBtn addTarget:self action:@selector(changeGateWay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setBtn];
    
}
-(void)changeGateWay
{
    if (self.gatewayTextField.text.length == 0) {
        [self showToastMessage:@"输入不能为空哦！"];
    }else{
        [WSGateway shareGateway].gateway.content = self.gatewayTextField.text;
        
        [[EGOCache globalCache] setObject:[WSGateway shareGateway].gateway forKey:kCacheGateWay];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [self showToastMessage:@"修改成功"];
    }

}

@end
