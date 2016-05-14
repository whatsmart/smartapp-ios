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
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.expired = [aDecoder decodeObjectForKey:@"expired"];
    }
    return self;
}

@end
