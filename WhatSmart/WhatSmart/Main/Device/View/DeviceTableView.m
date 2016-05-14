//
//  DeviceTableView.m
//  WhatSmart
//
//  Created by 董力云 on 16/4/19.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "DeviceTableView.h"
#import "DeviceModel.h"
#import "WSDeviceTableViewCell.h"


@implementation DeviceTableView 

-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
#pragma mark -UITableViewDeviceArray
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_DeviceArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuserIdentifier = @"devicecell";
    WSDeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier];
    if (cell == nil)
    {
        cell = [[WSDeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuserIdentifier];
    }
    DeviceModel *model =[_DeviceArray objectAtIndex:indexPath.row] ;
    cell.model = model;
    
    return cell;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
