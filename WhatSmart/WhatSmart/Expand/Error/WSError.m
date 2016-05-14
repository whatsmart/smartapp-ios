//
//  WSError.m
//  xman
//
//  Created by Wqiang on 16/2/23.
//  Copyright © 2016年 reapal. All rights reserved.
//

#import "WSError.h"

@implementation WSError

+ (WSError *)loadDataFromJson:(NSDictionary *)item
{
//    NSString *errCode = [item stringForKey:@"code"];
//    NSString *errCode = [item valueForKey:@"code"];
#warning todo 具体参数分析 自己网络请求使用
    NSString *errCode = @"1001";
    return [self errorWithErrorid:errCode];
}
+ (WSError *)errorWithErr:(NSString *)err
{
    WSError *errObj = [[WSError alloc]init];
    errObj.err = err;
    return errObj;
}
+ (WSError *)errorWithErrorid:(NSString *)errorid
{
    if (errorid.integerValue != 0)
    {
        NSString *err = NSLocalizedStringFromTable(errorid, @"XLocalizable", 1001);
        //判断是否返回的为key
        if ([err isEqualToString:errorid])
        {
            err = @"未知错误";
        }
        if (err.length) {
            WSError *e = [WSError errorWithErr:err];
            e.errorid = errorid;
            return e;
        }else
        {
            return [WSError errorWithErr:kRequestFailure];
        }
    }
    return nil;
}

@end
