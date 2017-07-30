//
//  CMDeviceInfo.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/30.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CMDeviceInfo : MTLModel<MTLJSONSerializing>

@property (nonatomic , copy) NSString *anonyId;

@end
