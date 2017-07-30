//
//  CMBasicDataManagerInterface.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/4.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  CMBasicDataManagerInterface <NSObject>

+ (BOOL)isNetworkReachable;

- (void)GET:(NSString *)URLString
 parameters:(nullable NSDictionary *)parameters
    success:(nullable void (^)(id data))success
       fail:(nullable void (^)(NSError *error))failure;

- (void)POST:(NSString *)URLString
  parameters:(nullable NSDictionary *)parameters
     success:(nullable void (^)(id data))success
     failure:(nullable void (^)(NSError *))failure;

- (void)POST:(NSString *)URLString
        name:(NSString *)name
    fileName:(NSString *)fileName
        data:(NSData *)uploadData
     success:(void (^)(id _Nonnull))success
     failure:(void (^)(NSError * _Nonnull))failure;

- (void)JSONPOST:(NSString *)URLString
      parameters:(NSDictionary *)parameters
         success:(void (^)(id _Nonnull))success
         failure:(void (^)(NSError * _Nonnull))failure;
@end
NS_ASSUME_NONNULL_END
