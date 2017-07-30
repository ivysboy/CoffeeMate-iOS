//
//  UIView+WYExtension.h
//  WuyuanAmazingAPP
//
//  Created by 徐悟源 on 16/3/16.
//  Copyright (c) 2016年 Wuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WYExtension)

@property (nonatomic , assign) CGSize my_Size;
@property (nonatomic , assign) CGFloat my_Width;
@property (nonatomic , assign) CGFloat my_Height;
@property (nonatomic , assign) CGFloat my_x;
@property (nonatomic , assign) CGFloat my_y;
@property (nonatomic , assign) CGFloat my_centerX;
@property (nonatomic , assign) CGFloat my_centerY;

// 判断一个控件是否真正显示在主窗口
- (BOOL)isShowingOnKeyWindow;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/

+ (instancetype)viewFromXib;

@end
