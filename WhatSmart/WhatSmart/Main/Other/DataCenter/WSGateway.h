//
//  WSGateway.h
//  WhatSmart
//
//  Created by 董力云 on 16/5/29.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gateway.h" 

@interface WSGateway : NSObject

@property (strong, nonatomic) Gateway * gateway;

+ (instancetype) shareGateway;


@end
