//
//  CMShareItemCell.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CMShareItemCell :UICollectionViewCell

- (void)updateCellWith:(NSString *)name image:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
