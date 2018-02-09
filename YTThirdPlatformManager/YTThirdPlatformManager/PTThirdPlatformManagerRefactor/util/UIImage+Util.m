//
//  UIImage+Util.m
//  MobileExperience
//
//  Created by fuyongle on 14-5-28.
//  Copyright (c) 2014年 NetDragon. All rights reserved.
//

#import "UIImage+Util.h"
#import <objc/runtime.h>
#import <WebKit/WebKit.h>
#import <UIImageView+WebCache.h>

@implementation UIImage (Util)

- (UIImage *)scaletoScale:(float)scaleSize {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width*scaleSize, self.size.height*scaleSize), NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width*scaleSize, self.size.height*scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)scaletoSize:(float)imageSize {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageSize, imageSize), NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, imageSize, imageSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
