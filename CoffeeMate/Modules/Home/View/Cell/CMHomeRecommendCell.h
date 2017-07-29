//
//  CMHomeRecommendCell.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CMHomeContentArticle;

@protocol CMHomeRecommendCellDelegate<NSObject>

@optional
- (void)handleArticleItemClick:(NSString *)articleId;

@end

@interface CMHomeRecommendCell : UITableViewCell

@property (nonatomic , weak) id<CMHomeRecommendCellDelegate> delegate;

- (void)configCellWith:(NSArray <CMHomeContentArticle *> *)articles title:(NSString *)title;
@end
NS_ASSUME_NONNULL_END
