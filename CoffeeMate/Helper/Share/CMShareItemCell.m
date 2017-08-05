//
//  CMShareItemCell.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMShareItemCell.h"

@interface CMShareItemCell ()

@property (nonatomic , strong) UIImageView *iconImageView;
@property (nonatomic , strong) UILabel *titleLabel;

@end


@implementation CMShareItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        [self installContraints];
    }
    
    return self;
}


- (void)setupSubViews {
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_iconImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_titleLabel setTextColor:[UIColor darkBlueColor]];
    [self.contentView addSubview:_titleLabel];
}

- (void)installContraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel , _iconImageView);
    NSDictionary *metrics = @{@"width" : @40, @"margin" : @15};
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin@750-[_iconImageView(width)]-[_titleLabel]-5@250-|" options:NSLayoutFormatAlignAllCenterX metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_iconImageView(width)]" options:0 metrics:metrics views:views]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_iconImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self setupSubViews];
    [self installContraints];
}

- (void)updateCellWith:(NSString *)name image:(NSString *)imageName {
    _iconImageView.image = [UIImage imageNamed:imageName];
    _titleLabel.text = name;
}


@end
