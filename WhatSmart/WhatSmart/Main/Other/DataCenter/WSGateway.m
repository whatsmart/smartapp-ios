//
//  WSGateway.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/29.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSGateway.h"

#import "getgateway.h"
#import <arpa/inet.h>
#import <netdb.h> 

@implementation WSGateway

static __strong WSGateway * _gatewayInstance;

-(instancetype) init
{
    self = [super init];
    
    if (self) {
        Gateway * gw = (Gateway*)[[EGOCache globalCache] objectForKey:kCacheGateWay];
        if (gw && gw.content) {
            self.gateway = [[Gateway alloc] initWithGateway:gw.content];

        }else{
#warning 此处上线时才获取路由器地址，现在写死
            NSString * router =  @""; //[self routerIp];
            if (router && router.length > 0) {
                
            }else{
                router = KGateWay;
            }
            self.gateway = [[Gateway alloc] initWithGateway:router];
        }
        
    }
    return self;
}

+(instancetype) shareGateway
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _gatewayInstance = [[WSGateway alloc] init];
    });
    return _gatewayInstance;
}

- (NSString *) routerIp {
    
    //获取设备路由器地址
    struct in_addr addr;
    getdefaultgateway(&(addr.s_addr));
    NSString * addrStr = [NSString stringWithUTF8String:inet_ntoa(addr)];
    
    NSLog(@"地址：%@",addrStr);
    return addrStr;
    
}

@end
