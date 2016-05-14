//
//  WSNetworkManager+Device.m
//  WhatSmart
//
//  Created by 董力云 on 16/4/17.
//  Copyright © 2016年 董力云. All rights reserved.
//
#import "WSNetworkManager.h"
#import "DeviceModel.h"

@implementation WSNetworkManager (Device)


-(void) GetDevices:(HttpFinishBlock)finish
{
    
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:[WSURL DeviceList]]];
    
    [client invokeMethod:@"get_devices" withParameters:nil requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (finish) {
            
            finish(responseObject,operation.response.statusCode);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (finish) {
            finish(error, operation.response.statusCode);
        }
    }];
}
@end
