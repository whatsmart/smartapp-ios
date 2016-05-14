//
//  WSTableView.h
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSViewController.h"

@interface WSTableView : UITableView
-(instancetype) initWithCoder:(NSCoder *)aDecoder;
-(void) addRefreshHeaderAndFooterTarget:(id)target HeaderAction:(SEL) HeaderAction FooterAction:(SEL) FooterAction;

@property (nonatomic,weak) WSViewController * owner;
@end
