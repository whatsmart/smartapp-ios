//
//  OrderTableViewCell.h
//  WhatSmart
//
//  Created by 董力云 on 16/5/28.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderTableViewCell : UITableViewCell

-(void) setDataWithModel:(OrderModel*) model;

@end
