//
//  PTBaseThirdPlatformManager.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTAbsThirdPlatformManager.h"

@interface PTBaseThirdPlatformManager : NSObject <PTAbsThirdPlatformManager>

@property (nonatomic, copy) void (^paymentBlock)(BOOL result);
@property (nonatomic, copy) void (^callback)(ThirdPlatformUserInfo* userInfo, NSError* err);
@property (nonatomic, copy) void (^shareResultBlock)(PTShareType, PTShareResult, NSError *);


// 第三方分享，子类重写该方法
- (void)doShareWithModel:(ThirdPlatformShareModel*)model;

@end
