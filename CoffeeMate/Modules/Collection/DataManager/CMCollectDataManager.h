//
// Created by 徐悟源 on 2017/8/9.
// Copyright (c) 2017 wuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMBasicDataManager.h"

@interface CMCollectDataManager : CMBasicDataManager

- (void)fetchCollectedArticlesListWithParameters:(NSDictionary *)parameters
                                success:(void (^)(id data))success
                                failure:(void (^)(NSError *error))failure;
@end