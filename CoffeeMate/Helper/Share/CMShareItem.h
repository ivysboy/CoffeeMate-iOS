//
//  CMShareItem.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMShareUtil.h"

@interface CMShareItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CMShareType type;
@property (nonatomic, copy) NSString *icon;

+ (instancetype)shareItemWithTitle:(NSString *)title type:(CMShareType)type icon:(NSString *)icon;
@end
