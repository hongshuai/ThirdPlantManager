//
//  NetworkRequestUtil.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/28.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequestUtil : NSObject

+ (void)requestWithURLString:(NSString*_Nullable)urlString  completionHandler:(void (^_Nullable)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;

@end
