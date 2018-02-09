//
//  PTTencentRespManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTTencentRespManager.h"
#import "PTThirdPlatformConfigConst.h"

@implementation PTTencentRespManager

DEF_SINGLETON

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:kTencentAppID andDelegate:self];
    }
    return self;
}

- (TencentOAuth *)tencentOAuth {
    if (!_tencentOAuth) {
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:kTencentAppID andDelegate:self];
    }
    return _tencentOAuth;
}

#pragma mark - ......::::::: TencentLoginDelegate :::::::......

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin {
    NSLog(@"===");
    [self.tencentOAuth getUserInfo];
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled {
    NSLog(@"===");
    if ([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
        [self.delegate respManagerDidRecvAuthResponse:nil platform:PTThirdPlatformTypeTencentQQ];
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork {
    NSLog(@"===");
    if ([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
        [self.delegate respManagerDidRecvAuthResponse:nil platform:PTThirdPlatformTypeTencentQQ];
    }
}


#pragma mark - ......::::::: TencentSessionDelegate :::::::......

/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response {
    NSLog(@"===");
    if (URLREQUEST_SUCCEED == response.retCode
        && kOpenSDKErrorSuccess == response.detailRetCode) {
        ThirdPlatformUserInfo *user = [ThirdPlatformUserInfo userbyTranslateTencentResult:response.jsonResponse];
        user.userId = self.tencentOAuth.openId;
        user.tokenString = self.tencentOAuth.accessToken;
        if ([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
            [self.delegate respManagerDidRecvAuthResponse:user platform:PTThirdPlatformTypeTencentQQ];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
            [self.delegate respManagerDidRecvAuthResponse:nil platform:PTThirdPlatformTypeTencentQQ];
        }
    }
}

/**
 * 社交API统一回调接口
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \param message 响应的消息，目前支持‘SendStory’,‘AppInvitation’，‘AppChallenge’，‘AppGiftRequest’
 */
- (void)responseDidReceived:(APIResponse*)response forMessage:(NSString *)message {
    NSLog(@"===");
}


/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req {
    NSLog(@"===");
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp {
    NSLog(@"===");
    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
        if ([self.delegate respondsToSelector:@selector(respManagerDidRecvMessageResponse:platform:)]) {
            if ([resp.result isEqualToString:@"0"]) {
                [self.delegate respManagerDidRecvMessageResponse:YES platform:PTShareTypeQQ];
            } else {
                [self.delegate respManagerDidRecvMessageResponse:NO platform:PTShareTypeQQ];
            }
        }
    }
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response {
    NSLog(@"===");
}

@end
