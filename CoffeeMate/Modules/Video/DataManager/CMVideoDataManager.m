//
//  CMVideoDataManager.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/30.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMVideoDataManager.h"
#import "CMVideoModule.h"
#import "CMVideoGroupModule.h"

@implementation CMVideoDataManager

- (void)fetchMainVideoListWith:(NSDictionary *)parameters
                   success:(void (^)(id data))success
                   failure:(void (^)(NSError *error))failure {
    
    [self GET:CMVideoListAPI parameters:parameters success:^(id  _Nonnull data) {
        NSError *error;
        NSArray<CMVideoGroupModule *> *videos = [MTLJSONAdapter modelsOfClass:[CMVideoGroupModule class] fromJSONArray:data error:&error];
        
        if(error) {
            failure(error);
        } else {
            success(videos);
        }
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)fetchVideoListWith:(NSDictionary *)parameters
                   success:(void (^)(id))success
                   failure:(void (^)(NSError *))failure {
    [self GET:CMVideoListByGroupIdAPI parameters:parameters success:^(id  _Nonnull data) {
        NSError *error;
        NSArray<CMVideoModule *> *videos = [MTLJSONAdapter modelsOfClass:[CMVideoModule class] fromJSONArray:data error:&error];
        
        if(error) {
            failure(error);
        } else {
            success(videos);
        }
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}
@end
