//
//  CMVideoModule.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/30.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CMVideoModule : MTLModel<MTLJSONSerializing>

@property (nonatomic , copy) NSString *videoId;
@property (nonatomic , copy) NSURL *videoUrl;
@property (nonatomic , copy) NSURL *coverUrl;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , strong) NSNumber *likeCount;

@end
