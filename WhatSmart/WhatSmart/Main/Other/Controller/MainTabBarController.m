//
//  MainTabBarController.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "MainTabBarController.h"
#import "TaskViewController.h"
#import "DeviceViewController.h"
#import "OrderViewController.h"
#import "WSNavigationController.h"
#import "WSUserCenterViewController.h"

@interface MainTabBarController ()

@property(nonatomic,strong) TaskViewController *    taskVC;
@property(nonatomic,strong) DeviceViewController *  deviceVC;
@property(nonatomic,strong) OrderViewController * messageVC;
@property(nonatomic,strong) WSUserCenterViewController *      meVC;



@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _taskVC = [[TaskViewController alloc] init];
    _taskVC.title = Title_Task;
    
    _deviceVC = [[DeviceViewController alloc] init];
    _deviceVC.title = Title_Device;
    
    _messageVC = [[OrderViewController alloc] init];
//    _messageVC.title = Title_Message;
    _messageVC.title = Title_Message;
    _meVC = [[WSUserCenterViewController alloc] init];
    _meVC.title = Title_Me;
    
    WSNavigationController * navTask = [[WSNavigationController alloc] initWithRootView:_taskVC withBarImage:@"prize" withBarSeletedImage:@"prize_hl"];
    
    WSNavigationController * navDevice = [[WSNavigationController alloc] initWithRootView:_deviceVC withBarImage:@"money" withBarSeletedImage:@"money_hl"];
    
    WSNavigationController * navMessage = [[WSNavigationController alloc] initWithRootView:_messageVC withBarImage:@"my" withBarSeletedImage:@"my_hl"];
    
    WSNavigationController * navMe = [[WSNavigationController alloc] initWithRootView:_meVC withBarImage:@"money" withBarSeletedImage:@"money_hl"];
    
    self.viewControllers = @[navMessage,navDevice,navTask,navMe];
    self.selectedIndex = 0;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
