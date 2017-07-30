//
//  CMRecommendInternalCell.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMRecommendInternalCell.h"
#import "UILabel+CMLabelAlignment.h"
#import "CMEdgeInsertLabel.h"
@interface CMRecommendInternalCell()

@property (nonatomic , strong) UIImageView *mainImage;

@property (nonatomic , strong) CMEdgeInsertLabel *nameLabel;

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UILabel *briefLabel;

@property (nonatomic , strong) UIButton *likeButton;

@end

@implementation CMRecommendInternalCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    _mainImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_mainImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    _mainImage.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:_mainImage];
    
    _nameLabel = [[CMEdgeInsertLabel alloc] initWithFrame:CGRectZero];
    [_nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.backgroundColor = [UIColor titleBlueColor];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_nameLabel];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_titleLabel];
    
    _briefLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_briefLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    _briefLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _briefLabel.numberOfLines = 0;
    _briefLabel.font = [UIFont systemFontOfSize:12];
    _briefLabel.textColor = [UIColor darkTextColor];
    [self.contentView addSubview:_briefLabel];
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [_likeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:_likeButton];
    
    NSDictionary *views = @{@"image" : _mainImage,
                            @"name" : _nameLabel,
                            @"title" : _titleLabel,
                            @"brief" : _briefLabel,
                            @"like" : _likeButton};
    NSDictionary *metrics = @{@"titleHeight" : @(0.1 * RecommendCellHeight), @"imageHeight" : @(0.45 * RecommendCellHeight)};
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[image]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[title]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[brief]-10-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[image(imageHeight)]-[title(titleHeight)]-5-[brief]-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_mainImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_nameLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_mainImage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_nameLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_mainImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:_nameLabel attribute:NSLayoutAttributeRight multiplier:1 constant:20]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_likeButton attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_likeButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-10]];
    [_briefLabel alignTop];
    
    self.contentView.layer.borderWidth = 0.5f;
    self.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.contentView.layer.cornerRadius = 5;
    self.contentView.clipsToBounds = YES;
}

- (void)configCellWith:(NSURL *)imageUrl
                  name:(NSString *)name
                 title:(NSString *)title
                 brief:(NSString *)brief {
    [_mainImage sd_setImageWithURL:imageUrl];
    [_nameLabel setText:name];
    [_titleLabel setText:title];
    [_briefLabel setText:brief];
    [_briefLabel alignTop];
}

@end
