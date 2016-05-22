//
//  WSToolsObject.h
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSToolsObject : NSObject

+ (float)getScreenWidth;

+ (float)getScreenHeight;

+ (float)getTabBarHeight;

+ (UIImage*)locationImageWithName:(NSString*)imageName;

+ (UIImage*)loadImageWithName:(NSString*)imageName;

+ (UIImage*)loadImageWithName:(NSString*)imageName type:(NSString*)type;

/*
 获取设备的型号代号
 输出参数：设备的型号代号字符串
 */

+ (NSString *)getDeviceVersion;
/*
 获取设备的型号
 输出参数：设备的型号字符串
 */
+ (NSString *)getPlatformString;

//是否需要解码优化（性能比较差的机型需要解码优化）
+ (BOOL)isNeedOptimizingWhenDecodeing;

@end
