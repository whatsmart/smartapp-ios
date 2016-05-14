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

@interface DeviceViewController ()
@property (nonatomic,strong) WSTableView * TableView;
//@property (weak, nonatomic) UIButton *reloadDataButton;

@property (nonatomic,strong) NSMutableArray * dataSource;

@end


@implementation DeviceViewController

@synthesize TableView;
@synthesize dataSource;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    
    if ([WSDataCenter shareDataCenter].DeviceArray) {
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

-(void)updateDeviceData
{
    if (self.dataSource.count > 0) {
        [self.dataSource removeAllObjects];
    }
    @synchronized (self.dataSource) {
        self.dataSource = [WSDataCenter shareDataCenter].DeviceArray;
    }
    [self.TableView reloadData];
}
#pragma mark 初始化view
- (void) setupView
{
    [self.TableView addRefreshHeaderAndFooterTarget:self HeaderAction:@selector(headerAction) FooterAction:@selector(footerAction)];
    [self.view addSubview:self.TableView];
    
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
    [self setupNotifications];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self removeNotification];
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
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([notification.userInfo[@"status"] isEqual:@YES]) {
        [self updateDeviceData];
    }
}

#pragma mark set
-(WSTableView *)TableView
{
    if (TableView == nil) {
        TableView = [[WSTableView alloc] initWithFrame:kScreenFrame];
        [TableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    }
    return TableView;
}

-(NSMutableArray *)dataSource
{
    if (dataSource == nil) {
        dataSource = [NSMutableArray new];
    }
    return dataSource;
}

@end
