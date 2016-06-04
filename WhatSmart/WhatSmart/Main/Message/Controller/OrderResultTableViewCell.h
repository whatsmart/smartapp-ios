//
//  OrderResultTableViewCell.h
//  WhatSmart
//
//  Created by 董力云 on 16/6/4.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderResultTableViewCell : UITableViewCell
-(void) setDataWithModel:(OrderModel*) model;

@end
