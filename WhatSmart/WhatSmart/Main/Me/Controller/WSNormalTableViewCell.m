//
//  WSNormalTableViewCell.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//
#import "WSNormalTableViewCell.h"

@interface WSNormalTableViewCell ()

@property (weak, nonatomic) UILabel *rightLabel;

@end

@implementation WSNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        //右侧描述label，修正系统自带detaillable对齐的bug
        UILabel *rightLabel = [[UILabel alloc] init];
        rightLabel.font = [UIFont systemFontOfSize:13];
        rightLabel.textColor = [UIColor grayColor];
        rightLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:rightLabel];
        self.rightLabel = rightLabel;
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-5);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
        }];
        
        if (!SYSTEM_VERSION_NEWER_OR_EQUAL_TO_7) {
            self.selectionStyle = UITableViewCellSelectionStyleGray;
            self.textLabel.backgroundColor = [UIColor whiteColor];
        }
        
        if (SYSTEM_VERSION_NEWER_OR_EQUAL_TO_7 && !SYSTEM_VERSION_NEWER_OR_EQUAL_TO_8) {//iOS7设置背景色透明
            self.backgroundColor = [UIColor clearColor];
        }
    }
    return self;
}

- (void)setRightTitle:(NSString *)rightTitle {
    _rightTitle = rightTitle;
    
    self.rightLabel.text = rightTitle;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat lineH = 0.3;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, RGBColor(0xe7, 0xe7, 0xe7).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - lineH, rect.size.width, lineH));
    
    if (!SYSTEM_VERSION_NEWER_OR_EQUAL_TO_7) {
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height - lineH));
    }
    
    if (SYSTEM_VERSION_NEWER_OR_EQUAL_TO_7 && !SYSTEM_VERSION_NEWER_OR_EQUAL_TO_8) {//iOS7绘制纯白背景
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height - lineH));
    }
}

@end
