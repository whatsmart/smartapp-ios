//
//  WSMacro.h
//  
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//
#import "AppDelegate.h"


#ifndef XMMacro_h
#define XMMacro_h

#define DATA_DEBUG_ON

#ifdef DATA_DEBUG_ON
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif


// ios系统版本

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SYSTEM_VERSION_OLDER_THAN_6 ([[[ UIDevice currentDevice ] systemVersion] floatValue] < 6.0)
#define SYSTEM_VERSION_NEWER_OR_EQUAL_TO_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define SYSTEM_VERSION_NEWER_OR_EQUAL_TO_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isRetina ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))

// 当前机型
#define iphone4x ([UIScreen mainScreen].bounds.size.height==480.0f)
#define iphone5x ([UIScreen mainScreen].bounds.size.height==568.0f)
#define iphone6  ([UIScreen mainScreen].bounds.size.height==667.0f)
#define iphone6P ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)

// app信息

#define appName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define appVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define appBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define APPLICATION_DELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define CUSTOMER_SERVICE_QQ @"709400432"

#pragma mark -

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//#define SYSTEM_VERSION_OLDER_THAN_6 ([[[ UIDevice currentDevice ] systemVersion] floatValue] < 6.0)
//#define SYSTEM_VERSION_NEWER_OR_EQUAL_TO_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//#define SYSTEM_VERSION_NEWER_OR_EQUAL_TO_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//
//#define	SCREEN_WIDTH [WSToolsObject getScreenWidth]
//#define	SCREEN_HEIGHT [WSToolsObject getScreenHeight]
//#define TABBAR_HEIGHT [WSToolsObject getTabBarHeight]
//#define SCREEN_RATIO SCREEN_WIDTH/320
//
//#define VERTICAL_SCREEN_RATIO SCREEN_WIDTH/375
//
//#define ZhangYuRed RGBColor(0xe8,0x20,0x58)
//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
//
//#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
//#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
//
//#define APPLICATION_DELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])
//
//#define  is4InchScreen ([[UIScreen mainScreen]bounds].size.height==568)


#endif /* XMMacro_h */
