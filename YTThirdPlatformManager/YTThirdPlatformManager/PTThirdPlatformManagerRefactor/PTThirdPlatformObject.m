//
//  PTThirdPlatformObject.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/24.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTThirdPlatformObject.h"
#import <WeiboSDK/WeiboUser.h>

@implementation PTThirdPlatformObject

@end


@implementation ThirdPlatformUserInfo


+ (ThirdPlatformUserInfo *)userbyTranslateSinaResult:(id)result {
    ThirdPlatformUserInfo *user = [[ThirdPlatformUserInfo alloc] init];
    user.thirdPlatformType = PTThirdPlatformTypeWeibo;
    
    if ([result isKindOfClass:[WeiboUser class]]) {
        WeiboUser *wbUser = (WeiboUser *)result;
        user.username = wbUser.screenName;
        user.gender = wbUser.gender;
        user.head = wbUser.avatarLargeUrl;
    }
    return user;
}


+ (ThirdPlatformUserInfo *)userbyTranslateTencentResult:(id)result {
    ThirdPlatformUserInfo *user = [[ThirdPlatformUserInfo alloc] init];
    user.thirdPlatformType = PTThirdPlatformTypeTencentQQ;
    
    if ([result isKindOfClass:[NSDictionary class]]) {
        user.gender = [result objectForKey:@"gender"];
        user.username = [result objectForKey:@"nickname"];
        user.head = [result objectForKey:@"figureurl_qq_2"];
        NSString *year = [result objectForKeyedSubscript:@"year"];
        NSDateFormatter *dateFoematter = [[NSDateFormatter alloc] init];
        [dateFoematter setDateFormat:@"yyyy"];
        NSString *currDate = [dateFoematter stringFromDate:[NSDate date]];
        int ageNum = [currDate intValue] - [year intValue];
        user.age = [NSString stringWithFormat:@"%d",ageNum];
    }
    return user;
}

@end


@implementation ThirdPlatformShareModel

@end


@implementation ThirdPlatformLoginModel

@end

