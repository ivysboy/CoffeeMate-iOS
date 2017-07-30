//
//  CMVideoModule.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/30.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMVideoModule.h"

@implementation CMVideoModule

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"videoId" : @"id",
             @"videoUrl" : @"videoUrl",
             @"coverUrl" : @"coverUrl",
             @"title" : @"title",
             @"likeCount" : @"like"};
}

@end
