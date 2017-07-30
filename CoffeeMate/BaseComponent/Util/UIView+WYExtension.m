//
//  UIView+WYExtension.m
//  WuyuanAmazingAPP
//
//  Created by 徐悟源 on 16/3/16.
//  Copyright (c) 2016年 Wuyuan. All rights reserved.
//

#import "UIView+WYExtension.h"

@implementation UIView (WYExtension)

- (void)setMy_Size:(CGSize)my_Size
{
    CGRect frame = self.frame;
    frame.size = my_Size;
    self.frame = frame;
}

- (CGSize)my_Size
{
    return self.frame.size;
}

- (void)setMy_Width:(CGFloat)my_Width
{
    CGRect frame = self.frame;
    frame.size.width = my_Width;
    self.frame = frame;
}

- (CGFloat)my_Width
{
    return self.frame.size.width;
}

- (void)setMy_Height:(CGFloat)my_Height
{
    CGRect frame = self.frame;
    frame.size.height = my_Height;
    self.frame = frame;
}

- (CGFloat)my_Height
{
    return self.frame.size.height;
}

- (void)setMy_x:(CGFloat)my_x
{
    CGRect frame = self.frame;
    frame.origin.x = my_x;
    self.frame = frame;
}

- (CGFloat)my_x
{
    return self.frame.origin.x;
}

- (void)setMy_y:(CGFloat)my_y
{
    CGRect frame = self.frame;
    frame.origin.y = my_y;
    self.frame = frame;
}

- (CGFloat)my_y
{
    return self.frame.origin.y;
}

- (void)setMy_centerX:(CGFloat)my_centerX
{
    CGPoint center = self.center;
    center.x = my_centerX;
    self.center = center;
}

- (CGFloat)my_centerX
{
    return self.center.x;
}

- (void)setMy_centerY:(CGFloat)my_centerY
{
    CGPoint center = self.center;
    center.y = my_centerY;
    self.center = center;
}

- (CGFloat)my_centerY
{
    return self.center.y;
}

- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点，计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self 的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.hidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

@end
