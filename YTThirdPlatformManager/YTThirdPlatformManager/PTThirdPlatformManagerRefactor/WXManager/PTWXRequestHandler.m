//
//  PTWXRequestHandler.m
//  YTThirdPlatformManager
//
//  Created by aron on 2017/10/26.
//  Copyright © 2017年 aron. All rights reserved.
//

#import "PTWXRequestHandler.h"
#import <WXApi.h>
#import "PTWXRespManager.h"
#import "PTOrderModel.h"
#import "PTThirdPlatformConfigConst.h"
#import "UIImage+Util.h"

@implementation PTWXRequestHandler

+ (BOOL)sendAuthInViewController:(UIViewController *)viewController {

    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = kAuthScope;
    req.state = kAuthOpenID;
    req.openID = kAuthOpenID;
    
    return [WXApi sendAuthReq:req
               viewController:viewController
                     delegate:[PTWXRespManager sharedInstance]];
    
}

+ (BOOL)payWithOrder:(PTOrderModel *)order {
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = order.partnerid;
    req.prepayId            = order.prepayid;
    req.nonceStr            = order.noncestr;
    req.timeStamp           = order.timestamp;
    req.package             = order.package;
    req.sign                = order.sign;
    BOOL result = [WXApi sendReq:req];
    return result;
}

// 分享
+ (BOOL)sendMessageWithModel:(ThirdPlatformShareModel*)model {
    enum WXScene wxScene = 0;
    if (PTShareTypeWechat == model.platform) {
        wxScene = WXSceneSession;
    } else if (PTShareTypeWechatLine == model.platform) {
        wxScene = WXSceneTimeline;
    }
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.scene = wxScene;
    req.bText = NO;
    WXMediaMessage* msg = [[WXMediaMessage alloc] init];
    msg.title = model.title;
    msg.description = model.text;
    [msg setThumbImage:[self scaledImageWithOriImage:model.image]];
    if (model.urlString && model.urlString.length>0) {
        WXWebpageObject* webPageObj = [[WXWebpageObject alloc] init];
        webPageObj.webpageUrl = model.urlString;
        msg.mediaObject = webPageObj;
    }
    req.message = msg;
    BOOL result = [WXApi sendReq:req];
    return result;
}

+ (UIImage*)scaledImageWithOriImage:(UIImage*)oriImage {
    NSInteger maxSharedImageBytes = 32*1000;//32K
    NSInteger oriImageBytes = UIImageJPEGRepresentation(oriImage, 1.0).length;
    if (oriImageBytes > maxSharedImageBytes) {
        CGFloat scaleFactor = maxSharedImageBytes * 1.0f / oriImageBytes * 1.0f;
        UIImage* scaledImage = [oriImage scaletoScale:scaleFactor];
        if (scaledImage) {
            return scaledImage;
        }
    }
    return oriImage;
}

@end
