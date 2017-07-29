//
//  CMHomeContent.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/30.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <Mantle/Mantle.h>

@class CMHomeContentArticle;

@interface CMHomeContent : MTLModel<MTLJSONSerializing>

@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *groupId;
@property (nonatomic , strong) NSArray <CMHomeContentArticle *>*articleList;

@end
