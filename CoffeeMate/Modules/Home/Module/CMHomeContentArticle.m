//
//  CMHomeContentArticle.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/30.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMHomeContentArticle.h"

@implementation CMHomeContentArticle

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"articleId" : @"id",
             @"title" : @"title",
             @"brief" : @"brief",
             @"auther" : @"auther",
             @"image" : @"image"};
}

@end
