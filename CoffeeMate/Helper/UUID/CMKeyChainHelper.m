//
//  JPKeyChainHelper.m
//  Jupiter
//
//  Created by 徐悟源 on 2017/1/17.
//  Copyright © 2017年 happylifeplat.com. All rights reserved.
//

#import "CMKeyChainHelper.h"
#import <Security/Security.h>

@implementation CMKeyChainHelper

#pragma mark - singleton instance method

+ (CMKeyChainHelper *)sharedHelper {
    static dispatch_once_t onceToken;
    static CMKeyChainHelper *sharedHelper;
    
    dispatch_once(&onceToken, ^{
        sharedHelper = [[CMKeyChainHelper alloc] init];
    });
    
    return sharedHelper;
}

#pragma mark - private method

- (NSMutableDictionary *)genericLookupDictionaryForIdentifier:(NSString *)identifier {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if(identifier) {
        NSData *identifierData = [identifier dataUsingEncoding:NSUTF8StringEncoding];
        [dictionary setObject:identifierData forKey:(__bridge id)kSecAttrAccount];
    }
    
    [dictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    NSString *service = [[NSBundle mainBundle] bundleIdentifier];
    if(service) {
        [dictionary setObject:service forKey:(__bridge id)kSecAttrService];
    }
    
    return dictionary;
}

- (BOOL)updateSecret:(NSString *)secret forKey:(NSString *)key {
    NSDictionary *query = [self genericLookupDictionaryForIdentifier:key];
    NSMutableDictionary *attributesToUpdate = [NSMutableDictionary dictionary];
    [attributesToUpdate setObject:[secret dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)attributesToUpdate);
    if(status != errSecSuccess) {
        NSLog(@"set secret failed");
        return NO;
    }
    return YES;
}

#pragma mark - JPKeyChainHelper CRUD method

- (BOOL)setSecret:(NSString *)secret forKey:(NSString *)key {
    NSMutableDictionary *dictionary = [self genericLookupDictionaryForIdentifier:key];
    
    [dictionary setObject:[secret dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
    if(status == errSecDuplicateItem) {
        return [self updateSecret:secret forKey:key];
    } else if (status != errSecSuccess) {
        return NO;
    }
    return YES;
}

- (NSString *)secretForKey:(NSString *)key {
    NSMutableDictionary *dictionary = [self genericLookupDictionaryForIdentifier:key];
    
    [dictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    [dictionary setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    CFTypeRef resultRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)dictionary, &resultRef);
    
    NSString *result = nil;
    if(status == errSecSuccess) {
        result = [[NSString alloc] initWithData:(__bridge_transfer id)resultRef encoding:NSUTF8StringEncoding];
    }
    
    return result;
    
}

- (BOOL)removeSecretForKey:(NSString *)key {
    NSDictionary *dictionary = [self genericLookupDictionaryForIdentifier:key];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef) dictionary);
    if(status != errSecSuccess) {
        NSLog(@"delete secret failed");
        return NO;
    }
    return YES;
}

@end
