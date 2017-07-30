//
//  CMVideoGroupModule.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/31.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMVideoGroupModule.h"
#import "CMVideoModule.h"

@implementation CMVideoGroupModule

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"groupId" : @"id",
             @"title" : @"title",
             @"index" : @"index",
             @"videos" : @"videos"};
}

+ (NSValueTransformer *)videosJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CMVideoModule class]];
}

@end
