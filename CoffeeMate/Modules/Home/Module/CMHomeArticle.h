//
//  CMHomeArticle.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/23.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CMHomeArticle : MTLModel<MTLJSONSerializing>

@property (nonatomic , copy) NSString *articleId;
@property (nonatomic , copy) NSURL *image;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *content;
@property (nonatomic , copy) NSString *brief;


@end
