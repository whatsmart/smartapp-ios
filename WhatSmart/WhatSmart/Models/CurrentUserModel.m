//
//  CurrentUserModel.m
//  testJSONRPC
//
//  Created by 董力云 on 16/4/18.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "CurrentUserModel.h"

@implementation CurrentUserModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.expired forKey:@"expired"];
    [aCoder encodeInteger:self.loginType forKey:@"loginType" ];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.group forKey:@"group"];
    [aCoder encodeObject:self.permission forKey:@"permission"];

}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.expired = [aDecoder decodeObjectForKey:@"expired"];
        self.loginType = [aDecoder decodeIntegerForKey:@"loginType"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.group = [aDecoder decodeObjectForKey:@"group"];
        self.permission = [aDecoder decodeObjectForKey:@"permission"];

    }
    return self;
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"name:%@, token:%@, group:%@, expired:%@, userId:%@, permission:%@",self.name,self.token,self.group,self.expired,self.userId,self.permission];
}

@end
