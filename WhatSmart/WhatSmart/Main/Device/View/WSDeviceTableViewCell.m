//
//  WSDeviceTableViewCell.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSDeviceTableViewCell.h"


@implementation WSDeviceTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //一次性代码  字体设置，样式设置
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //布局设置，  设置 各个控件frame
    
    
}


- (void)setModel:(WSDeviceCellModel *)model
{
    _model = model;
    
    //设置cell内容
    self.textLabel.text = model.title;
    self.detailTextLabel.text = model.detailTitle;
}

- (CGFloat)height
{
    
    return 100;
}
@end
