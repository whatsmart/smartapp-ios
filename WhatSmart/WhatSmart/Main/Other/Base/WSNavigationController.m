//
//  WSNavigationController.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSNavigationController.h"

@interface WSNavigationController ()

@end

@implementation WSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(instancetype) initWithRootView:(UIViewController*) rootViewController withBarImage:(NSString *) image withBarSeletedImage:(NSString*) selectedImage
{
    if (self = [super initWithRootViewController:rootViewController]) {
        UIImage* img =[UIImage imageNamed:image];
        //声明这张图片用原图(别渲染)
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage* img_selected= [UIImage imageNamed:selectedImage];
        img_selected = [img_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image=img;
        self.tabBarItem.selectedImage = img_selected;
        return self;
    }else{
        return nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
