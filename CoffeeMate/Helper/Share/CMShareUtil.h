//
//  CMShareUnit.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

typedef NS_ENUM(NSInteger, CMShareType) {
    CMShareTypeWXSession = 0,
    CMShareTypeWXTimeline,
    CMShareTypeSinaTimeline,
};

@class CMShareUtil;
@protocol CMShareUtilDelegate <NSObject>

@optional
- (void)shareUtil:(CMShareUtil *)shareUtil didSelectType:(CMShareType )shareType;
- (void)shareUtil:(CMShareUtil *)shareUtil cancelShare:(BOOL)canceled;

@end

@interface CMShareUtil : NSObject
@property (nonatomic ,assign) id <CMShareUtilDelegate>delegate;

+ (BOOL)canShare ;

- (BOOL)showShareUtil;

@end
