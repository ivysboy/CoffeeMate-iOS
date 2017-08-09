//
//  CMRecommendInternalCell.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMRecommendInternalCellDelegate <NSObject>

@optional
- (void)touchCollectButton:(NSString *)articleId;

@end

@interface CMRecommendInternalCell : UICollectionViewCell

@property (nonatomic , weak) id<CMRecommendInternalCellDelegate> delegate;

- (void)configCellWith:(NSURL *)imageUrl
                  name:(NSString *)name
                 title:(NSString *)title
                 brief:(NSString *)brief
             articleId:(NSString *)articleId;

@end
