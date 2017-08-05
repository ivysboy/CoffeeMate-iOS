//
//  CMShareItem.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//


#import "CMShareItem.h"

@implementation CMShareItem
+ (instancetype)shareItemWithTitle:(NSString *)title type:(CMShareType)type icon:(NSString *)icon {
    CMShareItem *item = [CMShareItem new];
    item.title = title;
    item.type = type;
    item.icon = icon;
    return item;
}
@end
