//
//  PTTencentManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTTencentManager.h"
#import "PTTencentRespManager.h"
#import "PTTencentRequestHandler.h"

@interface PTTencentManager () <PTAbsThirdPlatformRespManagerDelegate>
@end


@implementation PTTencentManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
    // 初始化QQ模块
    [PTTencentRespManager sharedInstance];
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // QQ 授权
    if ([TencentOAuth CanHandleOpenURL:url] && [TencentOAuth HandleOpenURL:url]) {
        return YES;
    }
    
    // QQ 业务
    if ([QQApiInterface handleOpenURL:url delegate:[PTTencentRespManager sharedInstance]]) {
        return YES;
    }
    
    return NO;
}

/**
 第三方登录
 */
- (void)signInWithType:(PTThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    self.callback = callback;
    [PTTencentRespManager sharedInstance].delegate = self;
    [PTTencentRequestHandler sendAuthInViewController:viewController];
}

// 分享
- (void)doShareWithModel:(ThirdPlatformShareModel *)model {
    self.shareResultBlock = model.shareResultBlock;
    [PTTencentRespManager sharedInstance].delegate = self;
    BOOL shareResult = [PTTencentRequestHandler sendMessageWithModel:model];
    if (shareResult == NO) {
        !self.shareResultBlock ?: self.shareResultBlock(PTShareTypeQQ, PTShareResultFailed, nil);
    }
}

- (BOOL)isThirdPlatformInstalled:(PTShareType)thirdPlatform {
    return [TencentOAuth iphoneQQInstalled] || [TencentOAuth iphoneTIMInstalled];
}

@end
