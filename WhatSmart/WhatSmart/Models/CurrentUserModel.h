//
//  CurrentUserModel.h
//  testJSONRPC
//
//  Created by 董力云 on 16/4/18.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    UserLoginTypeLogout = 0,
    UserLoginTypeQQ,
    UserLoginTypeSina,
    UserLoginTypeWS,
    UserLoginTypeWeCaChat,
} UserLoginType;


@interface CurrentUserModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * token;
@property (nonatomic,strong) NSNumber * expired;
@property (nonatomic,assign) UserLoginType loginType;
@property (nonatomic,strong) NSString * userId;
@property (nonatomic,strong) NSString * group;
@property (nonatomic,strong) NSDictionary * permission;

@end
