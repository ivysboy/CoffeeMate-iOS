//
//  AppDelegate.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/3.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "AppDelegate.h"
#import "CMTabBarController.h"
#import <FLEX/FLEXManager.h>
#import "AppDelegate+ThirdPart.h"
#import "AppDelegate+callback.h"
#import <AFNetworking/AFNetworking.h>
#import <JPush/JPUSHService.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [[UIScreen mainScreen] bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[CMTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    
    [self thirdPartSetup:launchOptions];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[FLEXManager sharedManager] showExplorer];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self handleThirdPartyCallBackWith:url];
}

#pragma mark -- Remote Notification with jpush

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSMutableString *str = [NSMutableString string];
    for(NSInteger i = 0, n = [deviceToken length]; i < n; i++) {
        unsigned int b = ((char *)[deviceToken bytes])[i];
        [str appendFormat:@"%02x", (0xFF & b)];
    }
    NSLog(@"token is : %@",str);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"receive remote notificationd");
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"receive remote notificationd userinfo :%@" , userInfo);
    if (userInfo[@"a"]) {
        [self handleThirdPartyCallBackWith:userInfo[@"a"]];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
}

@end
