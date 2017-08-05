
//
//  AppDelegate+ThirdPart.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "AppDelegate+ThirdPart.h"
#import <WechatOpenSDK/WXApi.h>

static NSString *kWeChatAppID = @"wx346186e6d3330a0d";

@implementation AppDelegate (ThirdPart)

- (void)thirdPartSetup:(NSDictionary *)option {
    [self setupWeChat];
}

- (void)setupWeChat {
    [WXApi registerApp:kWeChatAppID];
}

@end
