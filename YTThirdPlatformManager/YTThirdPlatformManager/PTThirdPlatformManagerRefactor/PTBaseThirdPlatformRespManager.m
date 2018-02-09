//
//  PTBaseThirdPlatformRespManager.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/27.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTBaseThirdPlatformRespManager.h"

@interface PTBaseThirdPlatformRespManager () {
    __weak id<PTAbsThirdPlatformRespManagerDelegate> _delegate;
}
@end

@implementation PTBaseThirdPlatformRespManager

- (void)setDelegate:(id<PTAbsThirdPlatformRespManagerDelegate>)delegate {
    _delegate = delegate;
}

- (id<PTAbsThirdPlatformRespManagerDelegate>)delegate {
    return _delegate;
}

@end
