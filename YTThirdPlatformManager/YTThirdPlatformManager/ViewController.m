//
//  ViewController.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/27.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "ViewController.h"
#import "PTThirdPlatformConfigManager.h"
#import "PTOrderModel.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    typeof(self) __weak weakSelf = self;
    [self addActionWithName:@"QQ Login" callback:^{
        [[PTThirdPlatformConfigManager sharedInstance] signInWithType:PTThirdPlatformTypeTencentQQ fromViewController:weakSelf callback:^(ThirdPlatformUserInfo *userInfo, NSError *err) {
            
        }];
    }];
    
    [self addActionWithName:@"Wechat Login" callback:^{
        [[PTThirdPlatformConfigManager sharedInstance] signInWithType:PTThirdPlatformTypeWechat fromViewController:weakSelf callback:^(ThirdPlatformUserInfo *userInfo, NSError *err) {
            
        }];
    }];
    
    [self addActionWithName:@"Weibo Login" callback:^{
        [[PTThirdPlatformConfigManager sharedInstance] signInWithType:PTThirdPlatformTypeWeibo fromViewController:weakSelf callback:^(ThirdPlatformUserInfo *userInfo, NSError *err) {
            
        }];
    }];
    
    // 分享模型
    ThirdPlatformShareModel* shareModel = [[ThirdPlatformShareModel alloc] init];
    shareModel.image = nil;
    shareModel.imageUrlString = @"";
    shareModel.title = @"title";
    shareModel.text = @"text";
    shareModel.weiboText = @"weibo text";
    shareModel.urlString = @"http://www.baidu.com";
    shareModel.fromViewController = self;
    shareModel.shareResultBlock = ^(PTShareType pplatform, PTShareResult result, NSError * error) {

    };

    
    [self addActionWithName:@"QQ Share" callback:^{
        shareModel.platform = PTShareTypeQQ;
        [[PTThirdPlatformConfigManager sharedInstance] shareWithModel:shareModel];
    }];
    
    [self addActionWithName:@"Wechat Share" callback:^{
        shareModel.platform = PTShareTypeWechat;
        [[PTThirdPlatformConfigManager sharedInstance] shareWithModel:shareModel];
    }];
    
    [self addActionWithName:@"Weibo Share" callback:^{
        shareModel.platform = PTShareTypeWeibo;
        [[PTThirdPlatformConfigManager sharedInstance] shareWithModel:shareModel];
    }];
    
    [self addActionWithName:@"Wechat Pay" callback:^{
        PTOrderModel* order = [[PTOrderModel alloc] init];
        [[PTThirdPlatformConfigManager sharedInstance] payWithPlateform:PaymentMethodTypeWechat order:order paymentBlock:^(BOOL result) {

        }];
    }];

    [self addActionWithName:@"Alipay Pay" callback:^{
        PTOrderModel* order = [[PTOrderModel alloc] init];
        [[PTThirdPlatformConfigManager sharedInstance] payWithPlateform:PaymentMethodTypeAlipay order:order paymentBlock:^(BOOL result) {

        }];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
