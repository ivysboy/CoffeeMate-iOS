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
@property (nonatomic , copy) NSString *groupId;

@end

@implementation CMRecommendCellHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
    }
    
    return self;
}

- (void)setupSubviews {
    self.contentView.backgroundColor = [UIColor viewBackgroundColor];
    
    _title = [[UILabel alloc] initWithFrame:CGRectZero];
    [_title setTranslatesAutoresizingMaskIntoConstraints:NO];
    _title.text = @"For you";
    _title.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:_title];
    
    _more = [[UILabel alloc] initWithFrame:CGRectZero];
    [_more setTranslatesAutoresizingMaskIntoConstraints:NO];
    _more.userInteractionEnabled = YES;
    _more.text = @"more";
    _more.textColor = [UIColor darkBlueColor];
    _more.font = [UIFont boldSystemFontOfSize:13];
    _more.textAlignment = NSTextAlignmentCenter;
    [_more addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMore)]];
    [self addSubview:_more];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_title attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_title attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];

    NSDictionary *views = @{@"more" : _more};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[more]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[more(64)]|" options:0 metrics:nil views:views]];
}

#pragma mark - tap more action
- (void)tapMore {
    if([_delegate respondsToSelector:@selector(clickForMore:)]) {
        [_delegate clickForMore:_groupId];
    }
}

- (void)configWith:(NSString *)title more:(NSString *)more groupId:(NSString *)groupId {
    _title.text = title;
    _more.text = more;
    _groupId = groupId;
}

@end
