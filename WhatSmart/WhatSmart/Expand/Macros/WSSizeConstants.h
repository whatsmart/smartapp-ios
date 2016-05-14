//
//  WSSizeConstants.h
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#ifndef XMSizeConstants_h
#define XMSizeConstants_h

// 屏幕宽高
#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height

// 屏幕frame,bounds,size
#define kScreenFrame  [UIScreen mainScreen].bounds
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenSize   [UIScreen mainScreen].bounds.size

#define kScreenCenterX ([UIScreen mainScreen].bounds.size.width/2.0 + [UIScreen mainScreen].bounds.origin.x)
#define kScreenCenterY ([UIScreen mainScreen].bounds.size.height/2.0 + [UIScreen mainScreen].bounds.origin.y)
#define kScreenCenter   CGPointMake(kScreenCenterX,kScreenCenterY)

#endif /* WSSizeConstants_h */
