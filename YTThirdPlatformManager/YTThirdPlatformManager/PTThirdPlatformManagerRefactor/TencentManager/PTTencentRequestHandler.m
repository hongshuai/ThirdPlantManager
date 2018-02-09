//
//  PTTencentRequestHandler.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTTencentRequestHandler.h"
#import "PTTencentRespManager.h"

@implementation PTTencentRequestHandler

// 第三方授权
+ (BOOL)sendAuthInViewController:(UIViewController *)viewController {
    NSArray* permissions = [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo", @"add_t", nil];
    BOOL result = [[PTTencentRespManager sharedInstance].tencentOAuth authorize:permissions inSafari:NO];
    return result;
}

// 分享
+ (BOOL)sendMessageWithModel:(ThirdPlatformShareModel *)model {
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:ValueOrEmpty(model.urlString)]
                                title:model.title
                                description:model.text
                                previewImageURL:[NSURL URLWithString:ValueOrEmpty(model.imageUrlString)]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    QQApiSendResultCode sent = 0;
    if (PTShareTypeQQ == model.platform) {
        //将内容分享到qq
        sent = [QQApiInterface sendReq:req];
    } else {
        //将内容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
    }
    return EQQAPISENDSUCESS == sent;
}

@end
