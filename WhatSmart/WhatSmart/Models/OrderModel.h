//
//  OrderModel.h
//  WhatSmart
//
//  Created by 董力云 on 16/5/28.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (assign, nonatomic) long long timestamp;
@property (strong, nonatomic) NSString * content;
@property (assign, nonatomic) BOOL isSelf;

-(OrderModel*) initWithDic:(NSDictionary*) dic;
@end
