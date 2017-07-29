//
//  CMHomeContent.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/30.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMHomeContent.h"
#import "CMHomeContentArticle.h"

@implementation CMHomeContent

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title" : @"title",
             @"groupId" : @"groupId",
             @"articleList" : @"articleList"
             };
}

+ (NSValueTransformer *)articleListJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CMHomeContentArticle class]];
}

@end
