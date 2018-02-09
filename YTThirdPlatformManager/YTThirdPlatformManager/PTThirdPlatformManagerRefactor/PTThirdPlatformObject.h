//
//  PTThirdPlatformObject.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/24.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PTThirdPlatformDefine.h"

@interface PTThirdPlatformObject : NSObject

@end


#pragma mark - ......::::::: ThirdPlatformUserInfo :::::::......

@interface ThirdPlatformUserInfo : NSObject
@property (nonatomic, assign) PTThirdPlatformType thirdPlatformType;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* head;
@property (nonatomic, copy) NSString* age;
@property (nonatomic, copy) NSString* gender;
@property (nonatomic, strong) NSDate* expirationDate;
@property (nonatomic, strong) NSString* tokenString;

+ (ThirdPlatformUserInfo *)userbyTranslateSinaResult:(id)result;
+ (ThirdPlatformUserInfo *)userbyTranslateTencentResult:(id)result;

@end


@interface ThirdPlatformShareModel : NSObject
@property (nonatomic, assign) PTShareType platform;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) NSString* imageUrlString;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSString* weiboText;
@property (nonatomic, strong) NSString* urlString;
@property (nonatomic, strong) UIViewController* fromViewController;
@property (nonatomic, copy) void (^shareResultBlock)(PTShareType pplatform, PTShareResult result, NSError *);
@end


@interface ThirdPlatformLoginModel : NSObject

@property (nonatomic, assign) PTThirdPlatformType thirdPlatformType;
@property (nonatomic, copy) NSString* icon;
@property (nonatomic, copy) NSString* name;
@end

