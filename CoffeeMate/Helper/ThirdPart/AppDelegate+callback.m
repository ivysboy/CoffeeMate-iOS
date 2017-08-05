//
//  AppDelegate+callback.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "AppDelegate+callback.h"

@implementation AppDelegate (callback)

- (BOOL)handleThirdPartyCallBackWith:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)onReq:(BaseReq*)req {
}

- (void)onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[SendMessageToWXResp class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CMWXShareCallbackNotification object:resp];
    }
}

@end
