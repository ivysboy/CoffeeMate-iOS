//
//  CMRecommendInternalCell.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMRecommendInternalCell.h"

#define ItemHeight ScreenSize.width * 180.0 /375

@interface CMRecommendInternalCell()

@property (nonatomic , strong) UIImageView *mainImage;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UILabel *briefLabel;

@property (nonatomic , strong) UIButton *likeButton;

@end

@implementation CMRecommendInternalCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    _mainImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_mainImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    _mainImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_mainImage];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_nameLabel];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:_titleLabel];
    
    _briefLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_briefLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    _briefLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _briefLabel.numberOfLines = 0;
    [self.contentView addSubview:_briefLabel];
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [_likeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:_likeButton];
    
    NSDictionary *views = @{@"image" : _mainImage,
                            @"name" : _nameLabel,
                            @"title" : _titleLabel,
                            @"brief" : _briefLabel,
                            @"like" : _likeButton};
    NSDictionary *metrics = @{@"titleHeight" : @(0.1 * ItemHeight), @"imageHeight" : @(0.45 * ItemHeight)};
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[image]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[title]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[brief]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[image(imageHeight)]-[title(titleHeight)]-[brief]|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_mainImage attribute:NSLayoutAttributeLeft | NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_nameLabel attribute:NSLayoutAttributeLeft | NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_mainImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:_nameLabel attribute:NSLayoutAttributeRight multiplier:1 constant:20]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_mainImage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_likeButton attribute:NSLayoutAttributeTop multiplier:1 constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-10]];
}

- (void)configCellWith:(NSURL *)imageUrl name:(NSString *)name title:(NSString *)title brief:(NSString *)brief {
    [_mainImage setImageWithURL:imageUrl];
    [_nameLabel setText:name];
    [_titleLabel setText:title];
    [_briefLabel setText:brief];
}

@end
