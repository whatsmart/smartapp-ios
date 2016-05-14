//
//  WSDataCenter+User.m
//  testJSONRPC
//
//  Created by 董力云 on 16/4/18.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSDataCenter.h"

@implementation WSDataCenter (User)

-(void) RegisterUserWithName:(NSString*) name andPassword:(NSString*) password  Completion:(void(^)(BOOL isSuccess, NSError* error)) completion
{
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:@"http://192.168.1.1/jsonrpc/1.0/user"]];
    [client.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"device-id"];
    
    DLog(@"注册用户......");
    [client invokeMethod:@"register_user" withParameters:@{@"username":name,@"password":password} requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：注册用户失败!错误信息：%@",error);
        completion(NO,error);
    }];
}

- (void) DeleteUserWithId:(NSString*) Id Completion:(void(^) (BOOL isSuccess, NSError* error)) completion
{
    NSString * urlString = [NSString stringWithFormat:@"http://192.168.1.1/jsonrpc/1.0/user/%@",Id];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    [client.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"device-id"];
    [client.requestSerializer setValue:[WSDataCenter shareDataCenter].currentUser.token forHTTPHeaderField:@"auth-token"];
    
    DLog(@"删除用户......");
    [client invokeMethod:@"delete_user" withParameters:nil requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：注册用户失败!错误信息：%@",error);
        completion(NO,error);
    }];
}

- (void) UpdateUserWithId:(NSString*) Id andName:(NSString*) name andPassword:(NSString*) password Completion:(void(^) (BOOL isSuccess, NSError* error)) completion
{
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:@"http://192.168.1.1/jsonrpc/1.0/user"]];
    [client.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"device-id"];
    [client.requestSerializer setValue:[WSDataCenter shareDataCenter].currentUser.token forHTTPHeaderField:@"auth-token"];

    DLog(@"更新用户......");
    [client invokeMethod:@"update_user" withParameters:@{@"username":name,@"password":password} requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(YES,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：更新用户失败!错误信息：%@",error);
        completion(NO,error);
    }];

}
- (void) GetUserWithId:(NSString*) Id Completion:(void(^) (BOOL isSuccess, UserModel* model)) completion
{
    NSString * urlString = [NSString stringWithFormat:@"http://192.168.1.1/jsonrpc/1.0/user/%@",Id];
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlString]];
    [client.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"device-id"];
    [client.requestSerializer setValue:[WSDataCenter shareDataCenter].currentUser.token forHTTPHeaderField:@"auth-token"];
    
    DLog(@"获取用户......");
    [client invokeMethod:@"get_user" withParameters:nil requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSDictionary class]]) {
            UserModel * model = [[UserModel alloc] initWithDic:[responseObject objectForKey:@"result"]];
            completion(YES,model);
        }
        completion(NO,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：获取用户失败!错误信息：%@",error);
        completion(NO,nil);
    }];
}
- (void) GetUserList:(void(^) (BOOL isSuccess, UserModel* model)) completion
{
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:@"http://192.168.1.1/jsonrpc/1.0/user"]];
    [client.requestSerializer setValue:[WSDataCenter shareDataCenter].currentUser.token forHTTPHeaderField:@"auth-token"];
    [client.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"device-id"];
    
    DLog(@"请求用户列表......");
    [client invokeMethod:@"get_users" withParameters:nil requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSArray class]]) {
            NSMutableArray * deviceModelArr = [NSMutableArray new];
            
            NSArray * result = [responseObject objectForKey:@"result"];
            for (NSDictionary * dic in result) {
                __block  UserModel * model = [[UserModel alloc] initWithDic:dic];
                [deviceModelArr addObject:model];
            }
            if (deviceModelArr.count > 0) {
                @synchronized (self.UserArray) {
                    self.UserArray = [NSMutableArray arrayWithObject:deviceModelArr];
                }
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:GetUserListDataRefreshed object:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：获取用户失败!错误信息：%@",error);
        [[NSNotificationCenter defaultCenter] postNotificationName:GetUserListDataRefreshed object:nil];
    }];
}
@end
