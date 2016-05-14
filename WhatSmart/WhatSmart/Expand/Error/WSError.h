//
//  WSError
//  xman
//
//  Created by Wqiang on 16/2/23.
//  Copyright © 2016年 reapal. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRequestFailure @"网络不给力，请稍后再试"

@interface WSError : NSObject
@property (nonatomic, strong) NSString *errorid;

@property (nonatomic, strong) NSString *err;
//再写一个接口通过errorid 返回错误信息 以及解析json数据
+ (WSError *)loadDataFromJson:(NSDictionary *)item;

+ (WSError *)errorWithErrorid:(NSString *)errorid;

+ (WSError *)errorWithErr:(NSString *)err;
@end
