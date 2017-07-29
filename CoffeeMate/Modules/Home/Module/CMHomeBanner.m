
//
//  CMHomeBanner.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/30.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMHomeBanner.h"

@implementation CMHomeBanner

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"bannerId" : @"id",
             @"title" : @"title",
             @"brief" : @"brief",
             @"auther" : @"auther",
             @"articleId" : @"articleId",
             @"image" : @"image"};
}

@end
