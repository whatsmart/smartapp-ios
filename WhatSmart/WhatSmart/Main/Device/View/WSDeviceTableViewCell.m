//
//  WSDeviceTableViewCell.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSDeviceTableViewCell.h"
#import "WSToolsObject.h"

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


- (void)setModel:(DeviceModel *)model
{
    _model = model;
    
    //设置cell内容
    NSString * title = [NSString stringWithFormat:@"%@(%@)",model.name,model.position];
    self.textLabel.text = title;
    if (model.state) {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"状态：%@ 亮度:%@", model.state.power, model.state.brightness];
        self.detailTextLabel.text = str;
    }
    [self.imageView setImage:[WSToolsObject loadImageWithName:@"device_lighting.png"]];
}

- (CGFloat)height
{
    
    return 100;
}
@end
