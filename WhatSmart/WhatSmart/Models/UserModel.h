//
//  UserModel.h
//  testJSONRPC
//
//  Created by 董力云 on 16/4/18.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * password;

- (UserModel *) initWithDic:(NSDictionary *) dic;
@end
