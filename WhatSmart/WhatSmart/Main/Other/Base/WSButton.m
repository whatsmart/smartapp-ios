//
//  WSButton.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/29.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSButton.h"

@implementation WSButton

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"确定" forState:UIControlStateNormal];
        [self setTintColor:[UIColor whiteColor]];
        self.backgroundColor = WSColor;
        self.layer.cornerRadius = 5;
    }
    
    return self;
}

@end
