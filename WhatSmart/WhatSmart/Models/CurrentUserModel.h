//
//  CurrentUserModel.h
//  testJSONRPC
//
//  Created by 董力云 on 16/4/18.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentUserModel : NSObject

@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * token;
@property (nonatomic,strong) NSNumber * expired;
@end
