//
//  WSDataCenter+Device.m
//  testJSONRPC
//
//  Created by 董力云 on 16/4/18.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSDataCenter.h"
#import "DeviceModel.h"


@implementation WSDataCenter (Device)

- (void)GetDeviceList
{
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:@"http://192.168.1.1/jsonrpc/1.0/device"]];
    [client.requestSerializer setValue:[WSDataCenter shareDataCenter].currentUser.token forHTTPHeaderField:@"auth-token"];
    [client.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"device-id"];
    
    DLog(@"请求获取设备列表......");
    [client invokeMethod:@"get_devices" withParameters:nil requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSArray class]]) {
            NSMutableArray * deviceModelArr = [NSMutableArray new];

            NSArray * result = [responseObject objectForKey:@"result"];
            for (NSDictionary * dic in result) {
                __block  DeviceModel * model = [[DeviceModel alloc] initWithDic:dic];
                [deviceModelArr addObject:model];
            }
            if (deviceModelArr.count > 0) {
                @synchronized (self.DeviceArray) {
                    self.DeviceArray = [NSMutableArray arrayWithObject:deviceModelArr];
                }
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:GetDeviceListDataRefreshed object:nil userInfo:@{@"status":@YES}];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：获取设备失败!错误信息：%@",error);
        [[NSNotificationCenter defaultCenter] postNotificationName:GetDeviceListDataRefreshed object:nil userInfo:@{@"status":@NO}];
    }];
}

- (void) GetDeviceWithId:(NSString*) Id Completion:(void(^)(BOOL isSuccess, DeviceModel *model))completion
{
    NSString * urlString = [[NSString alloc] initWithFormat:@"http://192.168.1.1/jsonrpc/1.0/device/%@",Id ];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    DLog(@"请求设备信息......");
    [client invokeMethod:@"get_device" withParameters:nil requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary * result = [responseObject objectForKey:@"result"];
            DeviceModel * model = [[DeviceModel alloc] initWithDic:result];
            completion(YES,model);
        }else{
            completion(NO,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：请求设备信息!错误信息：%@",error);
        completion(NO,nil);
    }];
}

- (void) SetNameWithId:(NSString*) Id andName:(NSString*) name Completion:(void(^)(BOOL isSuccess, NSError * error)) completion
{
    NSString * urlString = [[NSString alloc] initWithFormat:@"http://192.168.1.1/jsonrpc/1.0/device/%@",Id ];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    DLog(@"设置设备名字......");
    [client invokeMethod:@"set_name" withParameters:@{@"name":name} requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：设置设备名字!错误信息：%@",error);
        completion(NO,error);
    }];
}

- (void) SetPositionWithId:(NSString*) Id andPosition:(NSString*) position Completion:(void(^)(BOOL isSuccess, NSError * error)) completion
{
    NSString * urlString = [[NSString alloc] initWithFormat:@"http://192.168.1.1/jsonrpc/1.0/device/%@",Id ];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    DLog(@"设置设备位置......");
    [client invokeMethod:@"set_position" withParameters:@{@"position":position} requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：设置设备位置失败!错误信息：%@",error);
        completion(NO,error);
    }];
}

- (void) PowerOnWithId:(NSString*) Id Completion:(void(^)(BOOL isSuccess, NSError * error)) completion
{
    NSString * urlString = [[NSString alloc] initWithFormat:@"http://192.168.1.1/jsonrpc/1.0/control/%@",Id ];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    DLog(@"打开设备......");
    [client invokeMethod:@"power_on" withParameters:nil requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：打开设置失败!错误信息：%@",error);
        completion(NO,error);
    }];
}

- (void) PowerOffWithId:(NSString*) Id Completion:(void(^)(BOOL isSuccess, NSError * error)) completion
{
    NSString * urlString = [[NSString alloc] initWithFormat:@"http://192.168.1.1/jsonrpc/1.0/control/%@",Id ];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    DLog(@"关闭设备......");
    [client invokeMethod:@"power_off" withParameters:nil requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：关闭败!错误信息：%@",error);
        completion(NO,error);
    }];
}

- (void) GetPowerStateWithId:(NSString*) Id Completion:(void(^)(BOOL isSuccess, id response)) completion
{
    NSString * urlString = [[NSString alloc] initWithFormat:@"http://192.168.1.1/jsonrpc/1.0/control/%@",Id ];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    DLog(@"获取设备电量......");
    [client invokeMethod:@"get_power_state" withParameters:nil requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSString class]]) {
            completion(YES,[responseObject objectForKey:@"result"]);
        }else{
            completion(NO,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：获取设备电量失败!错误信息：%@",error);
        completion(NO,error);
    }];

}

- (void) SetBrightnessWithId:(NSString*) Id andBrightness:(NSNumber*) brighness Completion:(void(^)(BOOL isSuccess,NSError * error)) completion
{
    NSString * urlString = [[NSString alloc] initWithFormat:@"http://192.168.1.1/jsonrpc/1.0/control/%@",Id ];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    DLog(@"设置亮度......");
    [client invokeMethod:@"set_brightness" withParameters:@{@"brightness":brighness} requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：设置亮度!错误信息：%@",error);
        completion(NO,error);
    }];

}

- (void) GetBrightnessWithId:(NSString*) Id Completion:(void(^)(BOOL isSuccess, id response)) completion
{
    NSString * urlString = [[NSString alloc] initWithFormat:@"http://192.168.1.1/jsonrpc/1.0/control/%@",Id ];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    DLog(@"获取亮度......");
    [client invokeMethod:@"get_brightness" withParameters:nil requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSString class]]) {
            completion(YES,[responseObject objectForKey:@"result"]);
        }else{
            completion(NO,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：获取亮度!错误信息：%@",error);
        completion(NO,error);
    }];

}

- (void) SetColorWithId:(NSString*) Id andColor:(NSNumber*) color Completion:(void(^)(BOOL isSuccess,NSError * error)) completion
{
    NSString * urlString = [[NSString alloc] initWithFormat:@"http://192.168.1.1/jsonrpc/1.0/control/%@",Id ];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    DLog(@"设置颜色......");
    [client invokeMethod:@"set_color" withParameters:@{@"color":color} requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：设置颜色失败!错误信息：%@",error);
        completion(NO,error);
    }];
    
}

- (void) GetColorWithId:(NSString*) Id Completion:(void(^)(BOOL isSuccess,  NSNumber* color)) completion
{
    NSString * urlString = [[NSString alloc] initWithFormat:@"http://192.168.1.1/jsonrpc/1.0/control/%@",Id ];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    DLog(@"获取颜色......");
    [client invokeMethod:@"get_color" withParameters:nil requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSNumber class]]) {
            completion(YES,[responseObject objectForKey:@"result"]);
        }else{
            completion(NO,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：获取颜色失败!错误信息：%@",error);
        completion(NO,nil);
    }];
    
}

- (void) SendMessageWithId:(NSString *) Id andType:(NSString*) type andEncode:(NSString*) encode andContent:(NSString*) content Completion:(void(^)(BOOL isSuccess, NSError* error)) completion
{
    NSString * urlString = [[NSString alloc] initWithFormat:@"http://192.168.1.1/jsonrpc/1.0/control/%@",Id ];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    DLog(@"发送消息：%@......",content);
    [client invokeMethod:@"send_message" withParameters:@{@"type":type,@"encode":encode,@"content":content} requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：发送消息失败!错误信息：%@",error);
        completion(NO,error);
    }];
}














@end
