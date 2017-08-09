//
// Created by 徐悟源 on 2017/8/9.
// Copyright (c) 2017 wuyuan. All rights reserved.
//

#import "CMCollectDataManager.h"

@implementation CMCollectDataManager

- (void)fetchCollectedArticlesListWithParameters:(NSDictionary *)parameters success:(void (^)(id data))success failure:(void (^)(NSError *error))failure {

    [self GET:CMGetCollectedArticlesAPI parameters:parameters success:^(NSArray <NSString *>* data) {
        success(data);
    } fail:^(NSError *error) {
        failure(error);
    }];
}

@end