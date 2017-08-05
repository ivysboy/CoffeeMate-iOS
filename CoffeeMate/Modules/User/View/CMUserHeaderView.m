//
//  CMUserHeaderView.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/2.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMUserHeaderView.h"
#import "UILabel+util.h"

@implementation CMUserHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setupSubView];
    }
    
    return self;
}

- (void)setupSubView {
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectZero];
    [content setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:content];
    
    [content setText:@"致热爱生活的你：\n    我是Wuyuan，『咖啡伴我心』是我的一个side project，这个应用每天会分享3篇咖啡相关文章，两个咖啡冲泡技巧视频。文章的内容包含咖啡相关知识，历史文化，各种冲泡技艺教程等。这些文章和视频是我日常读到看到的觉得比较精彩的内容，拿来和大家分享。\n    『咖啡伴我心』，希望成为一个交流和传播精品咖啡文化的平台，让精品咖啡走向更多人的日常生活，让更多热爱咖啡的朋友能够更加了解精品咖啡。" lineSpacing:2.5];
    content.lineBreakMode = NSLineBreakByWordWrapping;
    content.numberOfLines = 0;
    content.font = [UIFont systemFontOfSize:14];
    content.textColor = [UIColor darkBlueColor];
    
    NSDictionary *views = @{@"content" : content};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[content]-20-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[content]-10-|" options:0 metrics:nil views:views]];
}

@end
