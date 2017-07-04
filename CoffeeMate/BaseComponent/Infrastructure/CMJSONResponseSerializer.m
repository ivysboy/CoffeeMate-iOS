//
//  CMJSONResponseSerializer.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/4.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMJSONResponseSerializer.h"
NSString *const kBussinessErrorDomain = @"com.wuyuan.network.response.json.serializer";
NSString *const kResultCode = @"resultCode";
NSString *const kMsg = @"msg";
NSString *const kData = @"data";

@implementation CMJSONResponseSerializer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.removesKeysWithNullValues = YES;
    }
    return self;
}

- (id)responseObjectForResponse:(nullable NSURLResponse *)response data:(nullable NSData *)data error:(NSError *__autoreleasing  __nullable * __nullable)error {
    id dictionary = [super responseObjectForResponse:response data:data error:error];
    if (*error != nil ) {//上层校验不通过直接返回
        return dictionary;
    }
    NSInteger resultCode = [((NSDictionary *)dictionary)[kResultCode] integerValue];
    NSString *msg = ((NSDictionary *)dictionary)[kMsg];
    if (resultCode != 200 ) {
        NSError *vError = [NSError errorWithDomain:kBussinessErrorDomain code:resultCode userInfo:@{kMsg : msg ? : @"unknown"}];
        
        *error = vError;
        return dictionary;
    }
    
    id vData = ((NSDictionary *)dictionary)[kData];
    return vData;
}
@end
