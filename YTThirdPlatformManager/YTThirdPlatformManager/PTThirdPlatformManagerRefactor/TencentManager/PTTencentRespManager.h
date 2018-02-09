//
//  PTTencentRespManager.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "PTBaseThirdPlatformRespManager.h"

@interface PTTencentRespManager : PTBaseThirdPlatformRespManager <TencentSessionDelegate, QQApiInterfaceDelegate>

AS_SINGLETON

@property (nonatomic, strong) TencentOAuth* tencentOAuth;

@end
