//
//  PTThirdPlatformDefine.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/23.
//  Copyright © 2017年 aron. All rights reserved.
//

#ifndef PTThirdPlatformDefine_h
#define PTThirdPlatformDefine_h


// 登录类型
typedef NS_ENUM(NSInteger, PTThirdPlatformType) {
    PTThirdPlatformTypeWechat = 1,//微信
    PTThirdPlatformTypeTencentQQ,//QQ
    PTThirdPlatformTypeWeibo,//微博
};

// 支付类型
typedef NS_ENUM(NSUInteger, PTPaymentMethodType) {
    PaymentMethodTypeWechat = 1,
    PaymentMethodTypeAlipay = 2,
    PaymentMethodTypeApple = 3,
};

// 分享类型
typedef NS_ENUM(NSInteger, PTShareType) {
    PTShareTypeUnknow,
    PTShareTypeWechat,
    PTShareTypeWechatLine,
    PTShareTypeQQ,
    PTShareTypeQQZone,
    PTShareTypeWeibo,
};

typedef NS_ENUM(NSInteger, PTShareResult) {
    PTShareResultSuccess,
    PTShareResultFailed,
    PTShareResultCancel,
};


#endif /* PTThirdPlatformDefine_h */
