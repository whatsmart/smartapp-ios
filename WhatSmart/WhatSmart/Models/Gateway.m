//
//  Gateway.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/29.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "Gateway.h"

@implementation Gateway


-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.content forKey:@"content"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.content = [aDecoder decodeObjectForKey:@"content"];
    }
    return self;
}

-(id) initWithGateway:(NSString*) gateway
{
    self = [super init];
    if (self) {
        self.content = [NSString stringWithString:gateway];
    }
    return self;
}
@end
