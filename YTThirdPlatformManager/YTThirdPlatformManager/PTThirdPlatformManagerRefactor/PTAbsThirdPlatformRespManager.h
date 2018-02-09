//
//  PTAbsThirdPlatformRespManager.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTThirdPlatformDefine.h"
#import "PTThirdPlatformObject.h"
#import "UtilMacro.h"

// RespManagerDelegate
@protocol PTAbsThirdPlatformRespManagerDelegate <NSObject>

@optional

- (void)respManagerDidRecvPayResponse:(BOOL)result platform:(PTPaymentMethodType)platform;
- (void)respManagerDidRecvAuthResponse:(ThirdPlatformUserInfo *)response platform:(PTThirdPlatformType)platform;
- (void)respManagerDidRecvMessageResponse:(BOOL)result platform:(PTShareType)platform;

@end


@protocol PTAbsThirdPlatformRespManager <NSObject>

@optional

// 代理，子类需要设置getter/setter
@property (nonatomic, weak) id<PTAbsThirdPlatformRespManagerDelegate> delegate;

@end

