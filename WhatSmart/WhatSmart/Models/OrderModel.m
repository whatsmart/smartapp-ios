//
//  OrderModel.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/28.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

-(OrderModel*) initWithDic:(NSDictionary*) dic
{
    if (self= [super init]) {
        self.timestamp   = [dic objectForKey:@"timestamp"];
        self.content  = [dic objectForKey:@"content"];
    }
    return self;
}
@end
