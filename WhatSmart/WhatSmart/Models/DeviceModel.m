//
//  DeviceModel.m
//  testJSONRPC
//
//  Created by 董力云 on 16/4/18.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "DeviceModel.h"

@implementation DeviceState

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
            self.state = [[DeviceState alloc] init];
            self.state.power = [[dic objectForKey:@"state"] objectForKey:@"power"];
            self.state.color = [[dic objectForKey:@"state"] objectForKey:@"color"];
            self.state.brightness = [[dic objectForKey:@"state"] objectForKey:@"brightness"];
        }
        return self;
    }
    return nil;
}
@end
