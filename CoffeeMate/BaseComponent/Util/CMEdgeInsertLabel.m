//
//  CMEdgeInsertLabel.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMEdgeInsertLabel.h"

@interface CMEdgeInsertLabel()

@property (nonatomic , assign) UIEdgeInsets edgeInsert;

@end

@implementation CMEdgeInsertLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.edgeInsert = UIEdgeInsetsMake(3, 3, 3, 3);
    }
    
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    /*
     调用父类该方法
     注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
     */
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds,self.edgeInsert) limitedToNumberOfLines:numberOfLines];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x -= self.edgeInsert.left;
    rect.origin.y -= self.edgeInsert.top;
    rect.size.width += self.edgeInsert.left + self.edgeInsert.right;
    rect.size.height += self.edgeInsert.top + self.edgeInsert.bottom;
    return rect;

}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsert)];
}

@end
