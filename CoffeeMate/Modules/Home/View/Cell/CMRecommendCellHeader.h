//
//  CMRecommendCellHeader.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMRecommendCellHeaderDelegate <NSObject>

@optional
- (void)clickForMore;

@end

@interface CMRecommendCellHeader : UITableViewHeaderFooterView

@property (nonatomic , weak) id<CMRecommendCellHeaderDelegate> delegate;
- (void)configWith:(NSString *)title more:(NSString *)more;
@end
