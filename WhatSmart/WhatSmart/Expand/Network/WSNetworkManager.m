//
//  WSNetworkManager.m
//  WhatSmart
//
//  Created by 董力云 on 16/4/17.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSNetworkManager.h"

@implementation WSNetworkManager

+ (instancetype) sharedInstance
{
    static  WSNetworkManager * manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[WSNetworkManager alloc] init];
    });
    return manager;
}
@end
