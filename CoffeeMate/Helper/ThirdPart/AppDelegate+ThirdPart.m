
//
//  AppDelegate+ThirdPart.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "AppDelegate+ThirdPart.h"
#import <WechatOpenSDK/WXApi.h>
#import <WeiboSDK/WeiboSDK.h>
#import <JPush/JPUSHService.h>

static NSString *kWeChatAppID = @"wx346186e6d3330a0d";
static NSString *kWeiboAppID = @"491834031";
static NSString *kJPushAppKey = @"f9e0b3b422f675e0f176d2fe";

@implementation AppDelegate (ThirdPart)

- (void)thirdPartSetup:(NSDictionary *)option {
    [self setupWeChat];
    [self setupWeibo];
    [self setupJpush:option];
}

- (void)setupWeChat {
    [WXApi registerApp:kWeChatAppID];
}

- (void)setupWeibo {
    [WeiboSDK registerApp:kWeiboAppID];
    
#ifdef DEBUG
    [WeiboSDK enableDebugMode:YES];
#endif
    
}


- (void)setupJpush:(NSDictionary *)option {
    
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];
    
    BOOL product = YES;
    NSString *channel = @"AppStore";
#ifdef DEBUG
    product = NO;
    channel = @"Debug";
#endif
    
    [JPUSHService setupWithOption:option
                           appKey:kJPushAppKey
                          channel:channel
                 apsForProduction:product];
    
    
    if (!product) {
        [JPUSHService setDebugMode];
        
    }
    
}

@end
