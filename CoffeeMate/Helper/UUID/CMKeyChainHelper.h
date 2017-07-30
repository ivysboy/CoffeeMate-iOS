//
//  JPKeyChainHelper.h
//  Jupiter
//
//  Created by 徐悟源 on 2017/1/17.
//  Copyright © 2017年 happylifeplat.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMKeyChainHelper : NSObject

+ (CMKeyChainHelper *)sharedHelper;

- (BOOL)setSecret:(NSString *)secret forKey:(NSString *)key;
- (NSString *)secretForKey:(NSString *)key;
- (BOOL)removeSecretForKey:(NSString *)key;

@end
