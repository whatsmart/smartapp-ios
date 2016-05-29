//
//  WSGateway.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/29.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSGateway.h"

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
            self.gateway = [[Gateway alloc] initWithGateway:KGateWay];
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

@end
