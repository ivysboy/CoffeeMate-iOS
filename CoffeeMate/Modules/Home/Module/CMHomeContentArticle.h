//
//  CMHomeContentArticle.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/30.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CMHomeContentArticle : MTLModel<MTLJSONSerializing>

@property (nonatomic , copy) NSString *articleId;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *auther;
@property (nonatomic , copy) NSString *brief;
@property (nonatomic , copy) NSURL *image;

@end
