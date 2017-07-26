//
//  CMHomeDataManager.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/23.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMHomeDataManager.h"
#import "CMHomeArticle.h"

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

@end
