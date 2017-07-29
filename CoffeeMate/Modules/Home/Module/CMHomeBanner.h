//
//  CMHomeBanner.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/30.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CMHomeBanner : MTLModel<MTLJSONSerializing>

@property (nonatomic , copy) NSString *bannerId;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *brief;
@property (nonatomic , copy) NSString *auther;
@property (nonatomic , copy) NSString *articleId;
@property (nonatomic , copy) NSURL *image;

@end
