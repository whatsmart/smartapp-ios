//
//  WSNavigationController.h
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSNavigationController : UINavigationController
-(instancetype) initWithRootView:(UIViewController*) rootViewController withBarImage:(NSString *) image withBarSeletedImage:(NSString*) selectedImage;

@end
