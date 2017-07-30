//
//  CMVideoDataManager.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/30.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMBasicDataManager.h"

@interface CMVideoDataManager : CMBasicDataManager

- (void)fetchMainVideoListWith:(NSDictionary *)parameters
                 success:(void (^)(id data))success
                 failure:(void (^)(NSError *error))failure;

- (void)fetchVideoListWith:(NSDictionary *)parameters
                       success:(void (^)(id data))success
                       failure:(void (^)(NSError *error))failure;
@end
