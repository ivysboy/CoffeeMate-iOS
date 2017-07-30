//
//  CMHomeDataManager.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/23.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMBasicDataManager.h"

@interface CMHomeDataManager : CMBasicDataManager

- (void)fetchArticlesListWithParameters:(NSDictionary *)parameters
                                success:(void (^)(id data))success
                                failure:(void (^)(NSError *error))failure;

- (void)fetchArticleWithParameter:(NSDictionary *)parameters
                          success:(void (^)(id data))success
                          failure:(void (^)(NSError *error))failure;

- (void)fetchHomeBannerWithParameter:(NSDictionary *)parameters
                             success:(void (^)(id data))success
                             failure:(void (^)(NSError *error))failure;

- (void)fetchHomeContentListWithParameter:(NSDictionary *)parameters
                                  success:(void (^)(id data))success
                                  failure:(void (^)(NSError *error))failure;

- (void)postDeviceInfoWith:(NSDictionary *)parameters
                   success:(void (^)(id data))success
                   failure:(void (^)(NSError *error))failure;

@end
