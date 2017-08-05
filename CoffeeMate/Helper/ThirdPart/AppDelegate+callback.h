//
//  AppDelegate+callback.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "AppDelegate.h"
#import <WechatOpenSDK/WXApi.h>

@interface AppDelegate (callback)<WXApiDelegate>
- (BOOL)handleThirdPartyCallBackWith:(NSURL *)url;

@end
