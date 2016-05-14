//
//  DeviceModel.h
//  testJSONRPC
//
//  Created by 董力云 on 16/4/18.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceStatus : NSObject

@property (nonatomic,strong) NSString * power ;
@property (nonatomic,assign) NSNumber * color ;
@property (nonatomic,assign) NSNumber * brightness;

@end

@interface DeviceModel : NSObject

/*
 {
 "id": 2312,
 "name": "智能灯",
 "position": "客厅",
 "vender": "Obama",
 "hwversion": "2.3",
 "swversion": "1.6",
 "type": "lighting",
 "operations": ["power_on", "power_off", "get_brightness", "set_brightness"],
 "status": {
 "power": "on",
 "color": 0x345423
 "brightness": 60
 }
 */

@property (nonatomic,strong) NSString * deviceId ;
@property (nonatomic,strong) NSString * name ;
@property (nonatomic,strong) NSString * position ;
@property (nonatomic,strong) NSString * vender ;
@property (nonatomic,strong) NSString * hwversion ;
@property (nonatomic,strong) NSString * swversion ;
@property (nonatomic,strong) NSString * type ;
@property (nonatomic,strong) NSArray * operations ;
@property (nonatomic,strong) DeviceStatus * status ;

- (DeviceModel *) initWithDic:(NSDictionary *) dic;
@end
