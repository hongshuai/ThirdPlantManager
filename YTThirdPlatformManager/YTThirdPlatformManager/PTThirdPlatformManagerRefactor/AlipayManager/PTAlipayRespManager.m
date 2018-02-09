//
//  PTAlipayRespManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTAlipayRespManager.h"

@implementation PTAlipayRespManager

DEF_SINGLETON

- (void)setResponse:(NSDictionary *)response {
    // 解析 resultStatus
    NSString* resultStatusStr = [response objectForKey:@"resultStatus"];
    BOOL result = NO;
    if ([resultStatusStr respondsToSelector:@selector(integerValue)]) {
        NSInteger resultStatus = [resultStatusStr integerValue];
        result = (resultStatus == 9000);
    }
    if ([self.delegate respondsToSelector:@selector(respManagerDidRecvPayResponse:platform:)]) {
        [self.delegate respManagerDidRecvPayResponse:result platform:PaymentMethodTypeAlipay];
    }
}

@end
