//
//  OrderModel.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/9/28.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTOrderModel.h"

@implementation PTOrderModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"orderID" : @"oId",
             @"sign": @[@"sign", @"body"],
             };
}

@end
