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
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:[WSURL UserUrl]]];
    [client.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"device-id"];
    
    DLog(@"注册用户......");
    [client invokeMethod:@"register_user" withParameters:@{@"username":name,@"password":password} requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.currentUser.name = name;
            self.currentUser.group = [responseObject valueForKey:@"group"];
            self.currentUser.userId = [responseObject valueForKey:@"id"];
            self.currentUser.token = [responseObject valueForKey:@"token"];
            self.currentUser.permission = [responseObject valueForKey:@"permission"] ;
            self.currentUser.loginType = UserLoginTypeWS;
            [[EGOCache globalCache]setObject:self.currentUser forKey:kCacheUserInfo];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:RegistUserNotifacationName object:@(YES)];
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:@(YES)];
        }else{
            NSString *desc = [responseObject valueForKey:@"error"];
            if(desc.length == 0 ){
                desc = @"注册失败";
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:RegistUserNotifacationName object:@(NO) userInfo:@{@"desc":desc}];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：注册用户失败!错误信息：%@",error);
        [[NSNotificationCenter defaultCenter] postNotificationName:RegistUserNotifacationName object:@(NO) userInfo:@{@"desc":@"网络连接失败"}];
    }];
}

- (void) LoginWithName:(NSString*)name andPassword:(NSString*) password Completion:(void(^)(BOOL isSuccess, NSError* error)) completion
{
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:[WSURL UserUrl]]];
    [client.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"device-id"];
    
    DLog(@"登录用户......");
//    client.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [client invokeMethod:@"login" withParameters:@{@"username":name,@"password":password} requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        completion(YES,nil);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
                self.currentUser.name = name;
                self.currentUser.group = [responseObject valueForKey:@"group"];
                self.currentUser.userId = [responseObject valueForKey:@"id"];
                self.currentUser.token = [responseObject valueForKey:@"token"];
                self.currentUser.permission = [responseObject valueForKey:@"permission"] ;
                self.currentUser.loginType = UserLoginTypeWS;
            [[EGOCache globalCache]setObject:self.currentUser forKey:kCacheUserInfo];

            [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:@(YES) userInfo:@{@"status":@YES}];

        }else{
            NSString *desc = [responseObject valueForKey:@"error"];
            if(desc.length == 0 ){
                desc = @"登录失败";
            }

            [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:@(NO) userInfo:@{@"desc":desc}];
        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：登录用户失败!错误信息：%@",error);
//        completion(NO,error);
        [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:@(NO) userInfo:@{@"desc":@"网络连接失败"}];

    }];
}
/**
 *  自动登录
 */
- (void)autoLogin{
    
    if (self.currentUser.loginType == UserLoginTypeLogout) {
        return;
    }
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:[WSURL UserUrl]]];
    [client.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"device-id"];
    
    DLog(@"登录用户......");
    //    client.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [client invokeMethod:@"login" withParameters:@{@"username":self.currentUser.name,@"password":@""} requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        completion(YES,nil);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.currentUser.group = [responseObject valueForKey:@"group"];
            self.currentUser.userId = [responseObject valueForKey:@"id"];
            self.currentUser.token = [responseObject valueForKey:@"token"];
            self.currentUser.permission = [responseObject valueForKey:@"permission"] ;
            self.currentUser.loginType = UserLoginTypeWS;
            [[EGOCache globalCache]setObject:self.currentUser forKey:kCacheUserInfo withTimeoutInterval:MAXFLOAT];
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:nil userInfo:@{@"status":@YES}];
            
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:nil userInfo:@{@"status":@NO}];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：登录用户失败!错误信息：%@",error);
        //        completion(NO,error);
        [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:nil userInfo:@{@"status":@NO}];
        
    }];
}


- (void) Logout:(void(^)(BOOL isSuccess, NSError* error)) completion
{
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:[WSURL UserUrl]]];
//    [client.requestSerializer setValue:[OpenUDID value] forHTTPHeaderField:@"device-id"];
    [client.requestSerializer setValue:[WSDataCenter shareDataCenter].currentUser.token forHTTPHeaderField:@"Auth-token"];

    DLog(@"注销用户......");
//    [client invokeMethod:@"logout" success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            self.currentUser.name = nil;
//            self.currentUser.group = nil;
//            self.currentUser.userId = nil;
//            self.currentUser.token = nil;
//            self.currentUser.permission = nil;
//            self.currentUser.loginType = UserLoginTypeLogout;
//            [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:nil];
//            
//        }else{
//            [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:nil userInfo:@{@"status":@YES}];
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"错误：注销用户失败!错误信息：%@",error);
//        //        completion(NO,error);
//        [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:nil userInfo:@{@"status":@YES}];
//        
//    }];

    [client invokeMethod:@"logout" withParameters:nil requestId:@(1) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        completion(YES,nil);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.currentUser.name = nil;
            self.currentUser.group = nil;
            self.currentUser.userId = nil;
            self.currentUser.token = nil;
            self.currentUser.permission = nil;
            self.currentUser.loginType = UserLoginTypeLogout;
            [[EGOCache globalCache]setObject:self.currentUser forKey:kCacheUserInfo];
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:nil];
            
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:nil userInfo:@{@"status":@YES}];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"错误：注销用户失败!错误信息：%@",error);
        //        completion(NO,error);
        [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateRefreshed object:nil userInfo:@{@"status":@YES}];
        
    }];
}


- (void) DeleteUserWithId:(NSString*) Id Completion:(void(^) (BOOL isSuccess, NSError* error)) completion
{
    NSString * urlString = [NSString stringWithFormat:[WSURL UserWithId],Id];
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
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:[WSURL UserUrl]]];
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
    NSString * urlString = [NSString stringWithFormat:[WSURL UserWithId],Id];
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
    AFJSONRPCClient * client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:[WSURL UserUrl]]];
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
