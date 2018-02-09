//
//  PTWXManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTWXManager.h"
#import "PTWXRespManager.h"
#import "PTWXRequestHandler.h"
#import <WXApi.h>
#import "PTThirdPlatformConfigConst.h"

@interface PTWXManager () <PTAbsThirdPlatformRespManagerDelegate>
@end


@implementation PTWXManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
    //向微信注册
    [WXApi registerApp:kWXAppID];
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // 微信
    if ([WXApi handleOpenURL:url delegate:[PTWXRespManager sharedInstance]]) {
        return YES;
    }
    return NO;
}

/**
 第三方登录
 */
- (void)signInWithType:(PTThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    self.callback = callback;
    [PTWXRespManager sharedInstance].delegate = self;
    [PTWXRequestHandler sendAuthInViewController:viewController];
}

// 分享
- (void)doShareWithModel:(ThirdPlatformShareModel *)model {
    self.shareResultBlock = model.shareResultBlock;
    [PTWXRespManager sharedInstance].delegate = self;
    BOOL shareResult = [PTWXRequestHandler sendMessageWithModel:model];
    if (shareResult == NO) {
        !self.shareResultBlock ?: self.shareResultBlock(PTShareTypeWechat, PTShareResultFailed, nil);
    }
}

/**
 第三方支付
 */
- (void)payWithPlateform:(PTPaymentMethodType)payMethodType order:(PTOrderModel*)order paymentBlock:(void (^)(BOOL result))paymentBlock {
    self.paymentBlock = paymentBlock;
    // 使用支付宝支付
    [PTWXRespManager sharedInstance].delegate = self;
    [PTWXRequestHandler payWithOrder:order];
}

- (BOOL)isThirdPlatformInstalled:(PTShareType)thirdPlatform {
    return [WXApi isWXAppInstalled];
}

@end
