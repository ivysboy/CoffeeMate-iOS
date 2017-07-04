//
//  CMJSONResponseSerializer.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/4.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "AFURLResponseSerialization.h"

@interface CMJSONResponseSerializer : AFJSONResponseSerializer<AFURLResponseSerialization>

@end
