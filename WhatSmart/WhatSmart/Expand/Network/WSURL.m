//
//  WSURL.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSURL.h"
#define kAPI(s) [KWSAPIHOSTURL stringByAppendingString:(s)]

@implementation WSURL

#warning 请求设备列表
+ (NSString*) DeviceList{return  kAPI(@"device"); }
+ (NSString*) DeviceWithId{return  kAPI(@"device/%@");}
+ (NSString*) ControlWithId{return kAPI(@"control/%@");}

+ (NSString*) UserUrl{return kAPI(@"user");}
+ (NSString*) UserWithId{return kAPI(@"user/%@");}


@end
