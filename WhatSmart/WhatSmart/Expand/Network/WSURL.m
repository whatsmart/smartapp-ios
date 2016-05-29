//
//  WSURL.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSURL.h"

#define  kHostUrl [[WSGateway shareGateway].gateway.content stringByAppendingString:@"/jsonrpc/v1.0/"]

#define kAPI(s) [kHostUrl stringByAppendingString:(s)]

@implementation WSURL

//设备
+ (NSString*) DeviceList{return  kAPI(@"device"); }
+ (NSString*) DeviceWithId{return  kAPI(@"device/%@");}
+ (NSString*) ControlWithId{return kAPI(@"control/%@");}
//用户
+ (NSString*) UserUrl{return kAPI(@"user");}
+ (NSString*) UserWithId{return kAPI(@"user/%@");}

@end
