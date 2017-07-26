//
//  CMHomeArticle.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/23.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMHomeArticle.h"

@implementation CMHomeArticle

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"articleId" : @"id",
             @"image" : @"image",
             @"name" : @"name",
             @"content" : @"content",
             @"brief" : @"brief"
             };
}

@end
