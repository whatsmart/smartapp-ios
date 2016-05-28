//
//  OrderTableViewCell.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/28.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "OrderTableViewCell.h"

@interface OrderTableViewCell()
@property (nonatomic, strong) OrderModel * model;
@property (nonatomic, strong) NSString * timeString;
@end

@implementation OrderTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialization code
        self.detailTextLabel.font = [UIFont systemFontOfSize:10];
    }
    return self;
}


-(void) setDataWithModel:(OrderModel*) model
{
    self.model = model;
    
    self.textLabel.text = model.content;

    NSDate * date = [NSDate dateWithTimeIntervalSince1970:model.timestamp];    
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天 HH:mm";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString *time = [formatter stringFromDate:date];

    self.timeString = [NSString stringWithString:time];
    
    NSString * string = [NSString stringWithFormat:@"%@",time];
    
    self.detailTextLabel.text = string;

}

@end
