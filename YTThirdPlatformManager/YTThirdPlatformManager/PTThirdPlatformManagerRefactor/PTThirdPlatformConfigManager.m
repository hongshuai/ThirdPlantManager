//
//  PTThirdPlatformConfigManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTThirdPlatformConfigManager.h"
#import "PTAbsThirdPlatformManager.h"

@implementation PTThirdPlatformConfigManager

DEF_SINGLETON

/**
 第三方平台配置
 */
- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (NSString* classString in [self thirdPlatformManagerClasses]) {
        id<PTAbsThirdPlatformManager> manager = [self managerFromClassString:classString];
        if (manager && [manager conformsToProtocol:@protocol(PTAbsThirdPlatformManager)]) {
            [manager thirdPlatConfigWithApplication:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    for (NSString* classString in [self thirdPlatformManagerClasses]) {
        id<PTAbsThirdPlatformManager> manager = [self managerFromClassString:classString];
        if (manager && [manager conformsToProtocol:@protocol(PTAbsThirdPlatformManager)]) {
            BOOL result = [manager thirdPlatCanOpenUrlWithApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
            if (result) {
                return YES;
            }
        }
    }
    return NO;
}

/**
 第三方登录
 
 @param thirdPlatformType 第三方平台
 @param viewController 从哪个页面调用的分享
 @param callback 登录回调
 */
- (void)signInWithType:(PTThirdPlatformType)thirdPlatformType
    fromViewController:(UIViewController *)viewController
              callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    NSString* classString = [[self thirdPlatformSigninManagerConfig] objectForKey:@(thirdPlatformType)];
    id<PTAbsThirdPlatformManager> manager = [self managerFromClassString:classString];
    [manager signInWithType:thirdPlatformType
         fromViewController:viewController
                   callback:callback];
}

- (void)shareWithModel:(ThirdPlatformShareModel *)model {
    NSString* classString = [[self thirdPlatformShareManagerConfig] objectForKey:@(model.platform)];
    id<PTAbsThirdPlatformManager> manager = [self managerFromClassString:classString];
    [manager shareWithModel:model];
}

/**
 第三方支付
 
 @param payMethodType 支付平台
 @param order 支付订单模型
 @param paymentBlock 支付结果回调
 */
- (void)payWithPlateform:(PTPaymentMethodType)payMethodType order:(PTOrderModel*)order paymentBlock:(void (^)(BOOL result))paymentBlock {
    NSString* classString = [[self thirdPlatformPayManagerConfig] objectForKey:@(payMethodType)];
    id<PTAbsThirdPlatformManager> manager = [self managerFromClassString:classString];
    [manager payWithPlateform:payMethodType
                        order:order
                 paymentBlock:paymentBlock];
}

- (id)managerFromClassString:(NSString*)classString {
    if (classString == nil || classString.length == 0) {
        return nil;
    }
    Class clz = NSClassFromString(classString);
    SEL sharedInstanceSelector = @selector(sharedInstance);
    id<PTAbsThirdPlatformManager> manager = nil;
    if(clz && [clz respondsToSelector:sharedInstanceSelector]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        // 这里的警告可以直接忽略，返回的是一个单例对象，不会有泄漏问题
        manager = [clz performSelector:sharedInstanceSelector];
#pragma clang diagnostic pop
    }
    return manager;
}

// 配置管理类
- (NSArray*)thirdPlatformManagerClasses {
    return @[@"PTAlipayManager",
             @"PTTencentManager",
             @"PTWeiboManager",
             @"PTWXManager",
             ];
}

// 配置第三方登录对应的管理类
- (NSDictionary*)thirdPlatformSigninManagerConfig {
    return @{
             @(PTThirdPlatformTypeWechat): @"PTWXManager",
             @(PTThirdPlatformTypeTencentQQ): @"PTTencentManager",
             @(PTThirdPlatformTypeWeibo): @"PTWeiboManager"
             };
}

// 配置第三方支付对应的管理类
- (NSDictionary*)thirdPlatformPayManagerConfig {
    return @{
             @(PaymentMethodTypeWechat): @"PTWXManager",
             @(PaymentMethodTypeAlipay): @"PTAlipayManager"
             };
}

// 配置第三方分享对应的管理类
- (NSDictionary*)thirdPlatformShareManagerConfig {
    return @{
             @(PaymentMethodTypeWechat): @"PTWXManager",
             @(PTShareTypeWechatLine): @"PTWXManager",
             @(PTShareTypeQQ): @"PTTencentManager",
             @(PTShareTypeQQZone): @"PTTencentManager",
             @(PTShareTypeWeibo): @"PTWeiboManager",
             };
}

@end
