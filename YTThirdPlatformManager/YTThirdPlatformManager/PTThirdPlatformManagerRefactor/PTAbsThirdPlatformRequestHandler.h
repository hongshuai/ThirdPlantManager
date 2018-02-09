//
//  PTAbsThirdPlatformRequestHandler.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PTThirdPlatformDefine.h"
#import "PTThirdPlatformObject.h"

@class PTOrderModel;

@protocol PTAbsThirdPlatformRequestHandler <NSObject>

@optional

// 第三方授权
+ (BOOL)sendAuthInViewController:(UIViewController *)viewController;

// 支付
+ (BOOL)payWithOrder:(PTOrderModel*)order;

// 分享
+ (BOOL)sendMessageWithModel:(ThirdPlatformShareModel*)model;

@end
