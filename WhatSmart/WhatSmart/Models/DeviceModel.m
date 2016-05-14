//
//  DeviceModel.m
//  testJSONRPC
//
//  Created by 董力云 on 16/4/18.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "DeviceModel.h"

@implementation DeviceStatus

-(instancetype) init
{
    if (self = [super init]) {
        return self;
    }
    return nil;
}

@end
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

@implementation DeviceModel

- (DeviceModel *) initWithDic:(NSDictionary *) dic
{
    if (self = [super init]) {
        if (dic != nil) {
            self.deviceId = [dic objectForKey:@"id"];
            self.name = [dic objectForKey:@"name"];
            self.position = [dic objectForKey:@"position"];
            self.vender = [dic objectForKey:@"vender"];
            self.hwversion = [dic objectForKey:@"hwversion"];
            self.swversion = [dic objectForKey:@"swversion"];
            self.type = [dic objectForKey:@"type"];
            self.operations = [dic objectForKey:@"operations"];
            self.status = [[DeviceStatus alloc] init];
            self.status.power = [[dic objectForKey:@"status"] objectForKey:@"power"];
            self.status.color = [[dic objectForKey:@"status"] objectForKey:@"color"];
            self.status.brightness = [[dic objectForKey:@"status"] objectForKey:@"brightness"];
        }
        return self;
    }
    return nil;
}
@end
