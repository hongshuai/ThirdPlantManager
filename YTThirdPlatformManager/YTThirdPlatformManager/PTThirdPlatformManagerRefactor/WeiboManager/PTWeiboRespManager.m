//
//  PTWeiboRespManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTWeiboRespManager.h"

@implementation PTWeiboRespManager

DEF_SINGLETON


#pragma mark - ......::::::: WeiboSDKDelegate :::::::......

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    // Nothing TODO
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        if ([self.delegate respondsToSelector:@selector(respManagerDidRecvMessageResponse:platform:)]) {
            [self.delegate respManagerDidRecvMessageResponse:(response.statusCode == WeiboSDKResponseStatusCodeSuccess) platform:PTShareTypeWeibo];
        }
    } else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        // 获取用户信息
        [self userWithAccessToken:[(WBAuthorizeResponse *)response accessToken] userId:[(WBAuthorizeResponse *)response userID]];
    }
}

- (void)userWithAccessToken:(NSString *)accessToken userId:(NSString *)userId {
    [WBHttpRequest requestForUserProfile:userId withAccessToken:accessToken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        if (error) {
            if ([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
                [self.delegate respManagerDidRecvAuthResponse:nil platform:PTThirdPlatformTypeWeibo];
            }
        }else{
            ThirdPlatformUserInfo *user = [ThirdPlatformUserInfo userbyTranslateSinaResult:result];
            user.userId = userId;
            user.tokenString = accessToken;
            
            if ([self.delegate respondsToSelector:@selector(respManagerDidRecvAuthResponse:platform:)]) {
                [self.delegate respManagerDidRecvAuthResponse:user platform:PTThirdPlatformTypeWeibo];
            }
        }
    }];
}

@end
