//
//  PTOrderModel.h
//  YTThirdPlatformManager
//
//  Created by aron on 2017/9/28.
//  Copyright © 2017年 aron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTOrderModel : NSObject
/** 商家向财付通申请的商家id */
@property (nonatomic, retain) NSString *partnerid;
/** 预支付订单 */
@property (nonatomic, retain) NSString *prepayid;
/** 随机串，防重发 */
@property (nonatomic, retain) NSString *noncestr;
/** 时间戳，防重发 */
@property (nonatomic, assign) UInt32 timestamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic, retain) NSString *package;
/** 商家根据微信开放平台文档对数据做的签名 */
@property (nonatomic, retain) NSString *sign;
/** 订单号 */
@property (nonatomic, strong) NSString* orderID;

@end
