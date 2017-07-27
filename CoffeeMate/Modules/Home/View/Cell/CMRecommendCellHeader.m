//
//  CMRecommendCellHeader.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMRecommendCellHeader.h"

@interface CMRecommendCellHeader()

@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UILabel *more;

@end

@implementation CMRecommendCellHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    self.backgroundColor = [UIColor viewBackgroundColor];
    
    _title = [[UILabel alloc] initWithFrame:CGRectZero];
    [_title setTranslatesAutoresizingMaskIntoConstraints:NO];
    _title.text = @"For you";
    _title.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:_title];
    
    _more = [[UILabel alloc] initWithFrame:CGRectZero];
    [_more setTranslatesAutoresizingMaskIntoConstraints:NO];
    _more.userInteractionEnabled = YES;
    _more.text = @"more";
    _more.textColor = [UIColor titleGreenColor];
    _more.font = [UIFont boldSystemFontOfSize:12];
    [_more addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMore)]];
    [self addSubview:_more];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_title attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:20]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_title attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_more attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-20]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_more attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

#pragma mark - tap more action
- (void)tapMore {
    
}

- (void)configWith:(NSString *)title more:(NSString *)more {
    _title.text = title;
    _more.text = more;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
