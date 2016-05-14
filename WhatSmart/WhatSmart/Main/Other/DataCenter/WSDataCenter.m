//
//  WSDataCenter.m
//  testJSONRPC
//
//  Created by 董力云 on 16/4/18.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSDataCenter.h"

@implementation WSDataCenter

static __strong WSDataCenter * _dataCenter;

-(instancetype) init
{
    if (self = [super init]) {
       
        _DeviceArray = [NSMutableArray array];
        _UserArray = [NSMutableArray array];
        _currentUser = [[CurrentUserModel alloc] init];
    }
    return self;
}

+ (instancetype) shareDataCenter
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _dataCenter = [[WSDataCenter alloc] init];
    });
    return _dataCenter;
}

@end
