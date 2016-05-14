//
//  WSTableView.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSTableView.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"

@implementation WSTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        self.tableFooterView = [[UIView alloc] init];//tableview空白不显示分割线
        
        return self;
    }
    return nil;
}

-(void) addRefreshHeaderAndFooterTarget:(id)target HeaderAction:(SEL) HeaderAction FooterAction:(SEL) FooterAction
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ([self.owner respondsToSelector:HeaderAction]) {
            [self.owner performSelector:HeaderAction];
        }
    }];
    
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ([self.owner respondsToSelector:FooterAction]) {
            [self.owner performSelector:FooterAction];
        }
    }];
}

@end
