//
//  PTWeiboManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTWeiboManager.h"
#import "PTWeiboRespManager.h"
#import "PTWeiboRequestHandler.h"
#import "PTThirdPlatformConfigConst.h"


@interface PTWeiboManager () <PTAbsThirdPlatformRespManagerDelegate>
@end

@implementation PTWeiboManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
    // 初始化微博模块
#if DEBUG
    [WeiboSDK enableDebugMode:YES];
#endif
    [WeiboSDK registerApp:kWeiboAppKey];
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // Weibo
    if ([WeiboSDK handleOpenURL:url delegate:[PTWeiboRespManager sharedInstance]]) {
        return YES;
    }
    
    return NO;
}

/**
 第三方登录
 */
- (void)signInWithType:(PTThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    self.callback = callback;
    [PTWeiboRespManager sharedInstance].delegate = self;
    [PTWeiboRequestHandler sendAuthInViewController:viewController];
}

// 分享
- (void)doShareWithModel:(ThirdPlatformShareModel *)model {
    self.shareResultBlock = model.shareResultBlock;
    [PTWeiboRespManager sharedInstance].delegate = self;
    BOOL shareResult = [PTWeiboRequestHandler sendMessageWithModel:model];
    if (shareResult == NO) {
        !self.shareResultBlock ?: self.shareResultBlock(model.platform, PTShareResultFailed, nil);
    }
}

- (BOOL)isThirdPlatformInstalled:(PTShareType)thirdPlatform {
    return [WeiboSDK isWeiboAppInstalled];
}

@end
