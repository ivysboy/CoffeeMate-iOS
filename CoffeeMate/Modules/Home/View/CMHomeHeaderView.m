//
//  CMHomeHeaderView.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMHomeHeaderView.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface CMHomeHeaderView()

@property (nonatomic , strong) UIView *titleView;
@property (nonatomic , strong) UIImageView *titleImage;
@property (nonatomic , strong) UIView *infoContainer;

@end



@implementation CMHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    self.backgroundColor = [UIColor whiteColor];
    
    _titleView = [self setupTitleView];
    [self addSubview:_titleView];
    
    _titleImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_titleImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    _titleImage.contentMode = UIViewContentModeScaleToFill;
    [_titleImage setImageWithURL:[NSURL URLWithString:@"http://static.ivysboy.com/images/3e811636-e541-4037-b263-58176157e6c2.jpg"]];
    [self addSubview:_titleImage];
    
    _infoContainer = [self setupInfoContainer];
    _infoContainer.backgroundColor = [UIColor darkBlueColor];
    [self addSubview:_infoContainer];
    
    NSDictionary *views = @{
                            @"titleView" : _titleView,
                            @"titleImage" : _titleImage,
                            @"infoContainer" : _infoContainer};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleImage]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleView(64)][titleImage]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[infoContainer]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[infoContainer(96)]|" options:0 metrics:nil views:views]];
    
}

- (UIView *)setupTitleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectZero];
    [titleView setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.text = @"Discovery";
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    [titleLable setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleView addSubview:titleLable];
    
    UIView *redline = [[UIView alloc] initWithFrame:CGRectZero];
    redline.backgroundColor = [UIColor highlightedColor];
    [redline setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleView addSubview:redline];
    
    NSDictionary *views = @{@"label" : titleLable,
                            @"redline" : redline};
    
    [titleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[label]" options:0 metrics:nil views:views]];
    [titleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[redline(40)]" options:0 metrics:nil views:views]];
    [titleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[label]" options:0 metrics:nil views:views]];
    [titleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[redline(2)]-20-|" options:0 metrics:nil views:views]];
    
    return titleView;
}

- (UIView *)setupInfoContainer {
    UIView *container = [[UIView alloc] initWithFrame:CGRectZero];
    [container setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return container;
}
@end
