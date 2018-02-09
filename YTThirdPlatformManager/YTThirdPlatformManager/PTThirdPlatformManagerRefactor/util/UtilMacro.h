//
//  UtilMacro.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/28.
//  Copyright © 2017年 aron. All rights reserved.
//

#ifndef UtilMacro_h
#define UtilMacro_h

#undef    AS_SINGLETON
#define AS_SINGLETON \
+ (instancetype)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON \
+ (instancetype)sharedInstance{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
} \

#define ValueOrEmpty(value)     ((value)?(value):@"")

static inline void PTOnMainThreadAsync(void (^block)()) {
    if ([NSThread isMainThread]) block();
    else dispatch_async(dispatch_get_main_queue(), block);
}

#endif /* UtilMacro_h */
