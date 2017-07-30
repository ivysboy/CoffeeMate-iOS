//
//  CMVideoGroupModule.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/31.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <Mantle/Mantle.h>
@class CMVideoModule;
@interface CMVideoGroupModule : MTLModel<MTLJSONSerializing>

@property (nonatomic , copy) NSString *groupId;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSNumber *index;
@property (nonatomic , strong) NSArray<CMVideoModule *>*videos;

@end
