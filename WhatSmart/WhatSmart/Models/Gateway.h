//
//  Gateway.h
//  WhatSmart
//
//  Created by 董力云 on 16/5/29.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gateway : NSObject <NSCoding>

@property (nonatomic, strong) NSString * content;

-(instancetype) initWithGateway:(NSString*) gateway;
@end
