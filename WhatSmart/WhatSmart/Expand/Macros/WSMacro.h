//
//  WSMacro.h
//  
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#ifndef XMMacro_h
#define XMMacro_h


#ifdef DATA_DEBUG_ON
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif


// ios系统版本
#define ios8x [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f
#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f
#define iosNot6x [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f

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

#endif /* XMMacro_h */
