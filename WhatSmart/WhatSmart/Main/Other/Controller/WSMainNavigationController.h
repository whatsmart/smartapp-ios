//
//  WSNavigationController.h
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSMainNavigationController : UINavigationController<UIGestureRecognizerDelegate, UIAlertViewDelegate>
@property (nonatomic,assign) BOOL canDragBack;

@end
