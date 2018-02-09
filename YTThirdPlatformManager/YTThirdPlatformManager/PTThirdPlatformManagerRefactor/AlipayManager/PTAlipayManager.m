//
//  PTAlipayManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTAlipayManager.h"
#import "PTAlipayRespManager.h"
#import "PTAlipayRequestHandler.h"
#import <AlipaySDK/AlipaySDK.h>

@interface PTAlipayManager () <PTAbsThirdPlatformRespManagerDelegate>
@end

@implementation PTAlipayManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // 支付宝
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [[PTAlipayRespManager sharedInstance] setResponse:resultDic];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            [[PTAlipayRespManager sharedInstance] setResponse:resultDic];
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        return YES;
    }
    return NO;
}

/**
 第三方支付
 */
- (void)payWithPlateform:(PTPaymentMethodType)payMethodType order:(PTOrderModel*)order paymentBlock:(void (^)(BOOL result))paymentBlock {
    self.paymentBlock = paymentBlock;
    // 使用支付宝支付
    [PTAlipayRespManager sharedInstance].delegate = self;
    [PTAlipayRequestHandler payWithOrder:order];
}

@end
