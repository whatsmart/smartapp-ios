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
//    _taskVC.title = Title_Task;
    _taskVC.navigationItem.title = Title_Task;
    
    _deviceVC = [[DeviceViewController alloc] init];
//    _deviceVC.title = Title_Device;
    _deviceVC.navigationItem.title = Title_Device;
    
    _messageVC = [[OrderViewController alloc] init];
    _messageVC.navigationItem.title = Title_Message;
//    _messageVC.title = Title_Message;
    
    _meVC = [[WSUserCenterViewController alloc] init];
//    _meVC.title = Title_Me;
    _meVC.navigationItem.title = Title_Me;
    
    WSNavigationController * navTask = [[WSNavigationController alloc] initWithRootView:_taskVC withBarImage:@"task" withBarSeletedImage:@"task_active"];
    
    WSNavigationController * navDevice = [[WSNavigationController alloc] initWithRootView:_deviceVC withBarImage:@"device" withBarSeletedImage:@"device_active"];
    
    WSNavigationController * navMessage = [[WSNavigationController alloc] initWithRootView:_messageVC withBarImage:@"msg" withBarSeletedImage:@"msg_active"];
    
    WSNavigationController * navMe = [[WSNavigationController alloc] initWithRootView:_meVC withBarImage:@"me" withBarSeletedImage:@"me_active"];
    
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
