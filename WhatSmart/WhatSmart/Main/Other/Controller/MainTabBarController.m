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
#import "MessageViewController.h"
#import "MeViewController.h"
#import "SettingViewController.h"
#import "WSNavigationController.h"

@interface MainTabBarController ()

@property(nonatomic,strong) TaskViewController *    taskVC;
@property(nonatomic,strong) DeviceViewController *  deviceVC;
@property(nonatomic,strong) MessageViewController * messageVC;
@property(nonatomic,strong) MeViewController *      meVC;
@property(nonatomic,strong) SettingViewController*  settingVC;



@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _taskVC = [[TaskViewController alloc] init];
    _taskVC.title = Title_Task;
    
    _deviceVC = [[DeviceViewController alloc] init];
    _deviceVC.title = Title_Device;
    
    _messageVC = [[MessageViewController alloc] init];
//    _messageVC.title = Title_Message;
    _messageVC.navigationItem.title = Title_Message;
    _meVC = [[MeViewController alloc] init];
    _meVC.title = Title_Me;
    
    _settingVC = [[SettingViewController alloc] init];
    _settingVC.title = Title_Setting;
    
    
    WSNavigationController * navTask = [[WSNavigationController alloc] initWithRootView:_taskVC withBarImage:@"prize" withBarSeletedImage:@"prize_hl"];
    
    WSNavigationController * navDevice = [[WSNavigationController alloc] initWithRootView:_deviceVC withBarImage:@"money" withBarSeletedImage:@"money_hl"];
    
    WSNavigationController * navMessage = [[WSNavigationController alloc] initWithRootView:_messageVC withBarImage:@"my" withBarSeletedImage:@"my_hl"];
    
    WSNavigationController * navMe = [[WSNavigationController alloc] initWithRootView:_meVC withBarImage:@"money" withBarSeletedImage:@"money_hl"];
    
    WSNavigationController * navSetting = [[WSNavigationController alloc] initWithRootView:_settingVC withBarImage:@"my" withBarSeletedImage:@"my_hl"];
    
    self.viewControllers = @[navTask,navDevice,navMessage,navMe,navSetting];
    self.selectedIndex = 2;

    
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
