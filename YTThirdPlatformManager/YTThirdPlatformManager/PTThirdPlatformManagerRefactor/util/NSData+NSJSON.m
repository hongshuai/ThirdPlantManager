//
//  NSData+NSJSON.m
//  MoboWiFi
//
//  Created by heyuan on 16/2/26.
//  Copyright © 2016年 mobo. All rights reserved.
//

#import "NSData+NSJSON.h"

@implementation NSData (NSJSON)

- (id)nsjsonObject {
    NSError *JSONSerializationError;
    id obj = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:&JSONSerializationError];
    
    if (JSONSerializationError) {
        NSLog(@"-NSJSONObject JSON Serialization Error is: %@", JSONSerializationError);
    }
    return obj;
}

@end
