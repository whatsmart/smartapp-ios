//
//  UserModel.m
//  testJSONRPC
//
//  Created by 董力云 on 16/4/18.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (UserModel *) initWithDic:(NSDictionary *) dic
{
    if (self = [super init]) {
        if (dic != nil) {
            self.name = [dic objectForKey:@"name"];
            self.password = [dic objectForKey:@"password"];
        }
        return self;
    }
    return nil;
}
@end
