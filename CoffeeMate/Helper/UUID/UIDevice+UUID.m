//
//  UIDevice+UUID.m
//  Jupiter
//
//  Created by Wuyuan on 17/1/19.
//  Copyright © 2017年 happylifeplat.com. All rights reserved.
//

#import "UIDevice+UUID.h"
#import "CMKeyChainHelper.h"

@implementation UIDevice (UUID)

- (NSString *)UUID {
    NSString *kJPUUIDKey = [NSString stringWithFormat:@"CMUUID::%@", [[NSBundle mainBundle] bundleIdentifier]];
    NSString *JPUUID = [[CMKeyChainHelper sharedHelper] secretForKey:kJPUUIDKey];
    if(!JPUUID) {
        JPUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [[CMKeyChainHelper sharedHelper] setSecret:JPUUID forKey:kJPUUIDKey];
        JPUUID = [[CMKeyChainHelper sharedHelper] secretForKey:kJPUUIDKey];
    }
    
    return JPUUID ? : @"";
}

@end
