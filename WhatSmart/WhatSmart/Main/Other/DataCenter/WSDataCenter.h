//
//  WSDataCenter.h
//  testJSONRPC
//
//  Created by 董力云 on 16/4/18.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFJSONRPCClient.h>
#import "NotificationHeader.h"
#import "DeviceModel.h"
#import "CurrentUserModel.h"
#import "OpenUDID.h"
#import "UserModel.h"
#import "WSURL.h"

@interface WSDataCenter : NSObject

@property (nonatomic,strong) NSMutableArray * DeviceArray;
@property (nonatomic,strong) NSMutableArray * UserArray;
@property (nonatomic,strong) CurrentUserModel * currentUser;

+ (instancetype) shareDataCenter;

@end

@implementation WSDataCenter (BaseData)

@end

@interface WSDataCenter (Device)

- (void) GetDeviceList;
- (void) GetDeviceWithId:(NSString*) Id Completion:(void(^)(BOOL isSuccess, DeviceModel * model))completion;
//????????????????? 返回值？
- (void) DiscoverDeviceWithType:(NSString*) type Completion:(void(^)(BOOL isSuccess, DeviceModel * model))completion;
- (void) SetNameWithId:(NSString*) Id andName:(NSString*) name Completion:(void(^)(BOOL isSuccess, NSError * error)) completion;
- (void) SetPositionWithId:(NSString*) Id andPosition:(NSString*) position Completion:(void(^)(BOOL isSuccess, NSError * error)) completion;

- (void) PowerOnWithId:(NSString*) Id Completion:(void(^)(BOOL isSuccess, NSError * error)) completion;
- (void) PowerOffWithId:(NSString*) Id Completion:(void(^)(BOOL isSuccess, NSError * error)) completion;
- (void) GetPowerStateWithId:(NSString*) Id Completion:(void(^)(BOOL isSuccess, id response)) completion;
- (void) SetBrightnessWithId:(NSString*) Id andBrightness:(NSNumber*) brighness Completion:(void(^)(BOOL isSuccess,NSError * error)) completion;
//????????????????? 得到返回数据哪个是亮度？
- (void) GetBrightnessWithId:(NSString*) Id Completion:(void(^)(BOOL isSuccess, id response)) completion;

- (void) SetColorWithId:(NSString*) Id andColor:(NSNumber*) color Completion:(void(^)(BOOL isSuccess,NSError * error)) completion;
//?????????????????
- (void) GetColorWithId:(NSString*) Id Completion:(void(^)(BOOL isSuccess, NSNumber* color)) completion;



//???? 消息接口 语音传送什么，是文字还是语音？ 密码加密吗?

- (void) SendMessageWithId:(NSString *) Id andType:(NSString*) type andEncode:(NSString*) encode andContent:(NSString*) content Completion:(void(^)(BOOL isSuccess, NSError* error)) completion;

@end

@interface WSDataCenter (User)

-(void) RegisterUserWithName:(NSString*) name andPassword:(NSString*) password  Completion:(void(^)(BOOL isSuccess, NSError* error)) completion;

- (void) DeleteUserWithId:(NSString*) Id Completion:(void(^) (BOOL isSuccess, NSError* error)) completion;

- (void) UpdateUserWithId:(NSString*) Id andName:(NSString*) name andPassword:(NSString*) password Completion:(void(^) (BOOL isSuccess, NSError* error)) completion;

- (void) GetUserWithId:(NSString*) Id Completion:(void(^) (BOOL isSuccess, UserModel* model)) completion;

- (void) GetUserList:(void(^) (BOOL isSuccess, UserModel* model)) completion;

//-(void) LoginWith

//???????? add_user 作用  用户id name

@end
