//
//  WSNetworkManager.h
//  WhatSmart
//
//  Created by 董力云 on 16/4/17.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFJSONRPCClient.h>
#import "WSURL.h"

//自己的网络请求使用
@class WSError;

typedef void(^HttpFinishBlock)(id responseObject, NSInteger statCode);

@interface WSNetworkManager : NSObject

+ (instancetype) sharedInstance;

@end

@interface WSNetworkManager (Device)

- (void) GetDevices: (HttpFinishBlock)finish;
@end