//
//  CMHomeHeaderView.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMHomeHeaderViewDelegate <NSObject>

@optional
- (void)tapHeaderWith:(NSString *)articleId;

@end

@interface CMHomeHeaderView : UIView

@property (nonatomic , weak) id<CMHomeHeaderViewDelegate> delegate;

- (void)configHeaderWith:(NSString *)title
            articleTitle:(NSString *)articleTitle
                  auther:(NSString *)auther
                   brief:(NSString *)brief
                   image:(NSURL *)image
               articleId:(NSString *)articleId;

@end
