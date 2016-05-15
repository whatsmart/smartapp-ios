//
//  ZYTVToolsObject.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//



#import "WSToolsObject.h"
#include <sys/sysctl.h>
#import "AppDelegate.h"

@implementation WSToolsObject

+ (float)getScreenWidth{
    
    float width = 0;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
        
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
            width = [UIScreen mainScreen].bounds.size.height;
        }else{
            width = [UIScreen mainScreen].bounds.size.width;
        }
    }else{
        width = [UIScreen mainScreen].bounds.size.width;
    }
    
    return width;
}

+ (float)getScreenHeight{
    
    float height = 0;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)){
            height = [UIScreen mainScreen].bounds.size.width;
        }else{
            height = [UIScreen mainScreen].bounds.size.height;
        }
    }else{
        height = [UIScreen mainScreen].bounds.size.height;
    }
    
    return height;
}

+ (float)getTabBarHeight{
    
    UINavigationController *navController = (UINavigationController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    UITabBarController * tmpTabBar  = (UITabBarController*)[[navController viewControllers]objectAtIndex:0];
    
    return tmpTabBar.tabBar.frame.size.height;
}

/*
 获取设备的型号代号
 输出参数：设备的型号代号字符串
 */
+ (NSString*)getDeviceVersion{
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

/*
 获取设备的型号
 输出参数：设备的型号字符串
 */
+ (NSString*)getPlatformString{
    NSString *platform = [WSToolsObject getDeviceVersion];
    // iphones
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (UK+Europe+Asis+China)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (UK+Europe+Asis+China)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 Plus";
    
    // ipods
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch (1 Gen)";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch (2 Gen)";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch (3 Gen)";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch (4 Gen)";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch (5 Gen)";
    
    // ipads
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"]) return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini Retina (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini Retina (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad Mini 3 (CDMA)";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad Mini 3 (CDMA)";
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2 (CDMA)";
    
    
    
    // simulators
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"] || [platform isEqualToString:@"ppc"] || [platform isEqualToString:@"ppc64"]) {
        return platform;
        
    }
    else return @"Unknown";
}

//是否需要解码优化（性能比较差的机型需要解码优化）
+ (BOOL)isNeedOptimizingWhenDecodeing{
    
    NSString *platform = [WSToolsObject getDeviceVersion];
    if ([platform hasPrefix:@"iPhone"]) {
        NSRange range = [platform rangeOfString:@","];
        if (range.length > 0) {
            NSRange verRange;
            verRange.location = @"iPhone".length;
            verRange.length = range.location - verRange.location;
            //小于6为iphone5/5c及以前的iphone
            if ([platform substringWithRange:verRange].integerValue < 6) {
                return YES;
            }
        }
    }
    
    else if ([platform hasPrefix:@"iPad"]) {
        NSRange range = [platform rangeOfString:@","];
        if (range.length > 0) {
            NSRange verRange,verRange2;
            verRange.location = @"iPad".length;
            verRange.length = range.location - verRange.location;
            
            verRange2.location = range.location + @",".length;
            verRange2.length = platform.length - range.location - @",".length;
            //小于4为ipad1，2,3,4和ipadmini1
            if ([platform substringWithRange:verRange].integerValue < 4)
            {
                return YES;
            }
            //等于3,几 为ipad3,4
            
            //            if ([platform substringWithRange:verRange].integerValue == 3 && [platform substringWithRange:verRange2].integerValue < 4)
            //            {
            //                return YES;
            //            }
        }
    }
    else if ([platform hasPrefix:@"iPod"]) {
        return YES;
    }
    
    
    return NO;
}

+ (UIImage*)locationImageWithName:(NSString*)imageName{
    
    NSRange range = [imageName rangeOfString:@"."];
    
    if(range.length>0){
        
        NSString *fileName = [imageName substringToIndex:range.location];
        NSString *extension = [imageName substringFromIndex:range.location+1];
//        PPwriteObject(fileName);
//        PPwriteObject(extension);
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        
        if (!imageData){
            fileName = [NSString stringWithFormat:@"%@@2x",fileName];
            filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
            imageData = [NSData dataWithContentsOfFile:filePath];
//			PPwriteObject(fileName);
//			PPwriteObject(extension);
        }
        
        return [UIImage imageWithData:imageData];
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    
    if (!imageData){
        filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@2x",imageName] ofType:@"png"];
        imageData = [NSData dataWithContentsOfFile:filePath];
    }
    
    return [UIImage imageWithData:imageData];
}

+ (UIImage*)loadImageWithName:(NSString*)imageName{
    
    NSRange range= [imageName rangeOfString:@"."];
    
    if(range.length>0){
        NSString *fileName = [imageName substringToIndex:range.location];
        NSString *extension = [imageName substringFromIndex:range.location+1];
        //		PPwriteObject(fileName);
        //		PPwriteObject(extension);
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        
        if (!imageData)
        {
            fileName = [NSString stringWithFormat:@"%@@2x",fileName];
            filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
            imageData = [NSData dataWithContentsOfFile:filePath];
            //			PPwriteObject(fileName);
            //			PPwriteObject(extension);
        }
        
        return [UIImage imageWithData:imageData];
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    
    if (!imageData)
    {
        filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@2x",imageName] ofType:@"png"];
        imageData = [NSData dataWithContentsOfFile:filePath];
    }
    
    return [UIImage imageWithData:imageData];
}

+ (UIImage *)loadImageWithName:(NSString *)imageName type:(NSString *)type{
    
    return [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imageName ofType:type]];
}

@end
