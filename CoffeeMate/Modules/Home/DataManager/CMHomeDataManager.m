//
//  CMHomeDataManager.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/23.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMHomeDataManager.h"
#import "CMHomeArticle.h"
#import "CMHomeBanner.h"
#import "CMHomeContent.h"
#import "CMDeviceInfo.h"

@implementation CMHomeDataManager

#pragma mark - Data method
- (void)fetchArticlesListWithParameters:(NSDictionary *)parameters
                  success:(void (^)(id data))success
                  failure:(void (^)(NSError *error))failure {
    [self GET:CMHomeArticlesListAPI parameters:parameters success:^(id  _Nonnull data) {
        NSError *error;
        NSArray<CMHomeArticle *> *articles = [MTLJSONAdapter modelsOfClass:[CMHomeArticle class] fromJSONArray:data error:&error];
        
        if(error) {
            failure(error);
        } else {
            success(articles);
        }
        
    } fail:^(NSError * _Nonnull error) {
       failure(error);
    
    }];
}

- (void)fetchArticleWithParameter:(NSDictionary *)parameters success:(void (^)(id data))success failure:(void (^)(NSError *error))failure {
    [self GET:CMArticleContentAPI parameters:parameters success:^(id  _Nonnull data) {
        NSError *error;
        CMHomeArticle *article = [MTLJSONAdapter modelOfClass:[CMHomeArticle class] fromJSONDictionary:data error:&error];
        
        if(error) {
            failure(error);
        } else {
            success(article);
        }
        
    } fail:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)fetchHomeBannerWithParameter:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self GET:CMHomeBannerAPI parameters:parameters success:^(id  _Nonnull data) {
        NSError *error;
        CMHomeBanner *banner = [MTLJSONAdapter modelOfClass:[CMHomeBanner class] fromJSONDictionary:data error:&error];
        
        if(error) {
            failure(error);
        } else {
            success(banner);
        }
    } fail:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)fetchHomeContentListWithParameter:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self GET:CMHomeContentListAPI parameters:parameters success:^(id  _Nonnull data) {
        NSError *error;
        NSArray <CMHomeContent *> *content = [MTLJSONAdapter modelsOfClass:[CMHomeContent class] fromJSONArray:data error:&error];
        
        if(error) {
            failure(error);
        } else {
            success(content);
        }
    } fail:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)postDeviceInfoWith:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self JSONPOST:CMCountDeviceLoginAPI parameters:parameters success:^(id _Nonnull data) {
        NSError *error;
        CMDeviceInfo *info = [MTLJSONAdapter modelOfClass:[CMDeviceInfo class] fromJSONDictionary:data error:&error];
        
        if(error) {
            failure(error);
        } else {
            success(info);
        }
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
