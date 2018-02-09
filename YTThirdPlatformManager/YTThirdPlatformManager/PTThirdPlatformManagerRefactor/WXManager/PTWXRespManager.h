//
//  PTWXRespManager.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTBaseThirdPlatformRespManager.h"
#import "WXApi.h"

@interface PTWXRespManager : PTBaseThirdPlatformRespManager <WXApiDelegate>

AS_SINGLETON

@end
