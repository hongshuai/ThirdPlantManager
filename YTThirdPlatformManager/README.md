# YTThirdPlatformManager
iOS第三方平台集成组件化

### 原理分析
参考我的博客文章[iOS第三方平台集成组件化](https://my.oschina.net/u/1242477/blog/1557875)

### 怎么使用

选择target ->  **YTThirdPlatformManager**    
![选择target ](https://gitee.com/uploads/images/2017/1101/122559_d5531c56_300384.png "选择target.png")  

示例代码：  
下面是不同平台调用第三发SDK的登录、分享、支付的功能示例代码，具体的可以下载项目代码查看。
```objc    
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
```

### 怎么配置
#### SDK配置
这部分可以参考各个平台的SDK配置，主要是配置KEY，APPID、infoplist、依赖库等信息，这里就不再一一例举了。  

- `PTThirdPlatformConfigConst.h` 配置文件  

APPID、APPKEY配置放置在 `PTThirdPlatformConfigConst.h` 文件中统一管理， `PTThirdPlatformConfigConst.h` 文件在该项目中没有配置，需要自行配置，创建一个Header类型的文件，命名为 `PTThirdPlatformConfigConst.h` 即可，对应的KEY可以从 `PTThirdPlatformConfigConstTemplate `文件中拷贝，Key对应的值配置为你申请的SDK的值即可。  

![创建配置文件](https://gitee.com/uploads/images/2017/1101/123735_dfde9dde_300384.png "创建配置文件.png")

- URL Types 配置  

这些配置使用到的key或者APPID部分需要自行完善，其中，**调用支付宝支付的 URL Schemes 代码调用和URL Types中的配置要保持一致**。  
![URL Types 配置](https://gitee.com/uploads/images/2017/1101/123222_94d68dd5_300384.png "URL Types.png")   


#### 添加了新的第三方SDK 

添加了新的第三方SDK，在SDK配置这个步骤好了之后，需要做以下事情
- 继承`PTBaseThirdPlatformManager`类生成一个第三方SDK的管理器
- 实现`PTAbsThirdPlatformRequestHandler`接口生成一个第三发SDK的底层调用
- 继承`PTBaseThirdPlatformRespManager`类生成一个第三方SDK的响应回调
以微信平台为例，生成三个平台相关的类文件：  
![微信平台文件](https://gitee.com/uploads/images/2017/1101/073749_321dd6da_300384.png "微信平台文件图.png")  

- 在配置中配置第三方平台管理类以及不同的类型对应的管理类  

```objc
// 配置管理类
- (NSArray*)thirdPlatformManagerClasses {
    return @[@"PTAlipayManager",
             @"PTTencentManager",
             @"PTWeiboManager",
             @"PTWXManager",
             ];
}

// 配置第三方登录对应的管理类
- (NSDictionary*)thirdPlatformSigninManagerConfig {
    return @{
             @(PTThirdPlatformTypeWechat): @"PTWXManager",
             @(PTThirdPlatformTypeTencentQQ): @"PTTencentManager",
             @(PTThirdPlatformTypeWeibo): @"PTWeiboManager"
             };
}

// 配置第三方支付对应的管理类
- (NSDictionary*)thirdPlatformPayManagerConfig {
    return @{
             @(PaymentMethodTypeWechat): @"PTWXManager",
             @(PaymentMethodTypeAlipay): @"PTAlipayManager"
             };
}

// 配置第三方分享对应的管理类
- (NSDictionary*)thirdPlatformShareManagerConfig {
    return @{
             @(PaymentMethodTypeWechat): @"PTWXManager",
             @(PTShareTypeWechatLine): @"PTWXManager",
             @(PTShareTypeQQ): @"PTTencentManager",
             @(PTShareTypeQQZone): @"PTTencentManager",
             @(PTShareTypeWeibo): @"PTWeiboManager",
             };
}
```
完了之后可以回到`怎么使用`步骤查看怎么使用了。

