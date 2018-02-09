//
//  PTAlipayRequestHandler.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTAlipayRequestHandler.h"
#import "PTAlipayRespManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PTOrderModel.h"

@implementation PTAlipayRequestHandler

// 支付
+ (BOOL)payWithOrder:(PTOrderModel*)order {
    // 开始支付
    NSString* orderString = order.sign;
    NSString* appScheme = @"alipayYTThirdPlatformManager";
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        [[PTAlipayRespManager sharedInstance] setResponse:resultDic];
    }];
    return YES;
}

@end
