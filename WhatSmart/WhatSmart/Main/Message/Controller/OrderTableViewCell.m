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

@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, strong) UIImageView * rightImageView;
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UILabel * msgLabel;
@end

@implementation OrderTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10,IMAHE_WIDTH, IMAHE_WIDTH)];
        _leftImageView.layer.cornerRadius = 5;
        [_leftImageView setImage:[UIImage imageNamed:@"msg_server"]];
        [self.contentView addSubview:_leftImageView];
        
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW-IMAHE_WIDTH-10, 10, IMAHE_WIDTH, IMAHE_WIDTH)];
        _rightImageView.layer.cornerRadius = 5;
        [_rightImageView setImage:[UIImage imageNamed:@"msg_me"]];
        [self.contentView addSubview:_rightImageView];
        
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_leftImageView.right, 10, _rightImageView.left-_leftImageView.right, 30)];
        [self.contentView addSubview:_backImageView];
        
        _msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, _backImageView.width-20, _backImageView.height-10)];
        _msgLabel.textColor= [UIColor blackColor];
        _msgLabel.backgroundColor = [UIColor clearColor];
        _msgLabel.font = [UIFont systemFontOfSize:15];
        _msgLabel.numberOfLines = 0;
        [_backImageView addSubview:_msgLabel];
        
    }
    return self;
}


-(void) setDataWithModel:(OrderModel*) model
{
    self.model = model;
    
//    self.textLabel.text = model.content;

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
    
    self.msgLabel.text = model.content;
    CGSize msgSize = [model.content sizeWithFont:self.msgLabel.font];
    NSInteger line = msgSize.width / (kScreenW-20-IMAHE_WIDTH*2-15) + 1;
    NSLog(@"msgSize:[%f %f],line:%ld",msgSize.width,msgSize.height,(long)line);
   
    UIImage * backImage = [[UIImage alloc] init];
    if (model.isSelf) {
        _leftImageView.hidden = YES;
        _rightImageView.hidden = NO;
        
        if (msgSize.width < kScreenW-20-IMAHE_WIDTH*2-15) {
            _backImageView.frame = CGRectMake(kScreenW-10-IMAHE_WIDTH-msgSize.width-15,10,msgSize.width+15, msgSize.height*line+15);
        }else{
            _backImageView.frame = CGRectMake(10+IMAHE_WIDTH,10, kScreenW-20-IMAHE_WIDTH*2, msgSize.height*line+15);
        }
        
        _msgLabel.frame = CGRectMake(5, 5,_backImageView.width-15, msgSize.height*line);
        backImage = [UIImage imageNamed:@"msg_bubble_myself"];
        UIImage * resizeImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 20, 20, 20)];
        [_backImageView setImage:resizeImage];
    }else{
        _leftImageView.hidden = NO;
        _rightImageView.hidden = YES;
        
        if (msgSize.width < kScreenW-20-IMAHE_WIDTH*2-15) {
            _backImageView.frame = CGRectMake(10+IMAHE_WIDTH,10,msgSize.width+15, msgSize.height*line+15);
        }else{
            _backImageView.frame = CGRectMake(10+IMAHE_WIDTH,10, kScreenW-20-IMAHE_WIDTH*2, msgSize.height*line+15);
        }

        backImage = [UIImage imageNamed:@"msg_bubble_server"];
        UIImage * resizeImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(30, 20, 20, 20)];
        [_backImageView setImage:resizeImage];

    }

}

@end
