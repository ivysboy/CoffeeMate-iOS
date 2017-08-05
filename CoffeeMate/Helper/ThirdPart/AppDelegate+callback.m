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
    if([WXApi handleOpenURL:url delegate:self]) {
        return YES;
    } else if([WeiboSDK handleOpenURL:url delegate:self]) {
        return YES;
    }
    return NO;
}

- (void)onReq:(BaseReq*)req {
}

- (void)onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[SendMessageToWXResp class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CMWXShareCallbackNotification object:resp];
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}


- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess && [response isKindOfClass:[WBAuthorizeResponse class]]){
        WBAuthorizeResponse *authorizeResponse = (WBAuthorizeResponse *)response;
        [self handleSinaLogin:authorizeResponse];
        
    } else if ([response isKindOfClass:[WBSendMessageToWeiboResponse class]]){
        [[NSNotificationCenter defaultCenter] postNotificationName:CMSinaShareCallBackNotification object:response];
    }
}

- (void)handleSinaLogin:(WBAuthorizeResponse *)response {
    NSDictionary *authData = @{
                               @"userId" : response.userID ,
                               @"accessToken" : response.accessToken,
                               @"expirationDate" : @([response.expirationDate timeIntervalSinceReferenceDate]),
                               @"refreshToken" : response.refreshToken
                               };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CMSinaAuthSuccessNotification object:nil userInfo:authData];
}

@end
