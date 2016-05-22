//
//  DeviceViewController.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "DeviceViewController.h"
#import "WSTableView.h"
#import "MJRefresh.h"
#import "UIButton+Block.h"
#import "DeviceTableView.h"

@interface DeviceViewController ()
@property (nonatomic,strong) DeviceTableView * tableView;
//@property (weak, nonatomic) UIButton *reloadDataButton;

//@property (nonatomic,strong) NSMutableArray * dataSource;

@end


@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self setupNotifications];

    if ([WSDataCenter shareDataCenter].DeviceArray.count > 0) {
        [self updateDeviceData];
    }else{
        [[WSDataCenter shareDataCenter] GetDeviceList];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [self removeNotification];
}

-(void)updateDeviceData
{
    if (self.tableView.deviceArray.count > 0) {
        [self.tableView.deviceArray removeAllObjects];
    }
    @synchronized (self.tableView.deviceArray) {
        self.tableView.deviceArray = [WSDataCenter shareDataCenter].DeviceArray;
    }
    [self.tableView reloadData];
}
#pragma mark 初始化view
- (void) setupView
{
    
    [self.tableView addRefreshHeaderAndFooterTarget:self HeaderAction:@selector(headerAction) FooterAction:@selector(footerAction)];
    [self.view addSubview:self.tableView];
    
//    //重新加载按钮
//    UIButton *reloadDataButton = [[UIButton alloc] init];
//    reloadDataButton.hidden = YES;
//    reloadDataButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    [reloadDataButton setTitle:@"点我重新加载" forState:UIControlStateNormal];
//    [reloadDataButton setTitleColor:RGBColor(222, 222, 222) forState:UIControlStateNormal];
//    self.TableView.backgroundView = reloadDataButton;
//    self.reloadDataButton = reloadDataButton;
//    __weak __typeof(&*self)weakSelf = self;
//    [reloadDataButton addActionHandler:^(NSInteger tag) {
//        weakSelf.reloadDataButton.hidden = YES;
//        [[WSDataCenter shareDataCenter] GetDeviceList];
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    }];

}

#pragma mark tableview refresh
-(void)headerAction
{
    [[WSDataCenter shareDataCenter] GetDeviceList];
}
-(void)footerAction
{
    
}
#pragma mark 接收通知
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(void) setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(get_notification:) name:GetDeviceListDataRefreshed object:nil];
}
-(void) removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GetDeviceListDataRefreshed object:nil];
}
#pragma mark 通知处理
-(void)get_notification:(NSNotification*) notification
{
    [self.tableView.mj_header endRefreshing ];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([notification.userInfo[@"status"] isEqual:@YES]) {
        [self updateDeviceData];
    }
}

#pragma mark set
-(DeviceTableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[DeviceTableView alloc] initWithFrame:kScreenFrame];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        _tableView.owner = self;
        _tableView.fatherVC = self;
    }
    return _tableView;
}

//-(NSMutableArray *)dataSource
//{
//    if (_dataSource == nil) {
//        _dataSource = [NSMutableArray new];
//    }
//    return _dataSource;
//}

@end
