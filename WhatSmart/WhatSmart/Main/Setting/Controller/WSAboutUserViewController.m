//
//  WSAboutUserViewController.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//
//  关于我们 界面

#import "WSAboutUserViewController.h"

@interface WSAboutUserViewController ()

@end

@implementation WSAboutUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化界面
    [self setUpView];
}

#pragma mark - 初始化界面
- (void)setUpView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTopBar];
    [self creatNavBackButton];
    self.title = @"关于我们";
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aboutlogo"]];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(96);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 100));
    }];
    
    
    NSString *(^GetVersion)() = ^{
        return [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    };
    
    //版本号
    UILabel *versionLabel = [UILabel new];
    versionLabel.attributedText = [self attributeStringWithLeftString:@"版本号：" leftFontSize:17 leftFontColor:nil
                                                          rightString:GetVersion() rightFontSize:17 rightFontColor:[UIColor redColor]];
    [self.view addSubview:versionLabel];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_bottom).offset(59);
        make.left.equalTo(logoImageView);
    }];
    
    //官方网站
    UILabel *webSiteLabel = [UILabel new];
    webSiteLabel.attributedText = [self attributeStringWithLeftString:@"官方网站：" leftFontSize:17 leftFontColor:nil
                                                          rightString:@"xxxxx" rightFontSize:17 rightFontColor:WSColor];
    [self.view addSubview:webSiteLabel];
    [webSiteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(versionLabel.mas_bottom).offset(15);
        make.left.equalTo(versionLabel);
    }];
    
    //客服QQ
    UILabel *QQLabel = [UILabel new];
    QQLabel.attributedText = [self attributeStringWithLeftString:@"客服QQ：" leftFontSize:17 leftFontColor:nil rightString:CUSTOMER_SERVICE_QQ rightFontSize:17 rightFontColor:WSColor];
    [self.view addSubview:QQLabel];
    [QQLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(webSiteLabel.mas_bottom).offset(15);
        make.left.equalTo(webSiteLabel);
    }];
}

#pragma mark - 构造多属性字符串
- (NSAttributedString *)attributeStringWithLeftString:(NSString * __nonnull)leftString leftFontSize:(CGFloat)leftFontSize leftFontColor:(UIColor *)leftFontColor
                                          rightString:(NSString * __nonnull)rightSring rightFontSize:(CGFloat)rightFontSize rightFontColor:(UIColor *)rightFontColor {
    
    //空值处理
    if (!leftFontSize) leftFontSize = 17;
    if (!leftFontColor) leftFontColor = [UIColor blackColor];
    if (!rightFontSize) rightFontSize = 17;
    if (!rightFontColor) rightFontColor = [UIColor blackColor];
    
    //设置属性
    NSString *allString = [NSString stringWithFormat:@"%@%@",leftString,rightSring];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:allString];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:leftFontSize] range:NSMakeRange(0, leftString.length)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:leftFontColor range:NSMakeRange(0, leftString.length)];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:rightFontSize] range:NSMakeRange(leftString.length, rightSring.length)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:rightFontColor range:NSMakeRange(leftString.length, rightSring.length)];
    
    return attributeString;
}

#pragma mark - 统计相关
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

@end
