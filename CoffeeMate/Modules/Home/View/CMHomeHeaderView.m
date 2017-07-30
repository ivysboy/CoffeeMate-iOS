//
//  CMHomeHeaderView.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMHomeHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CMHomeHeaderView()

@property (nonatomic , strong) UIView *titleView;
@property (nonatomic , strong) UILabel *hugeLabel;
@property (nonatomic , strong) UIImageView *titleImage;
@property (nonatomic , strong) UIView *infoContainer;
@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UILabel *brief;
@property (nonatomic , strong) UILabel *auther;

@property (nonatomic , strong) UIView *tapView;
@property (nonatomic , copy) NSString *articleId;

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
    [self addSubview:_titleImage];
    
    _infoContainer = [self setupInfoContainer];
    _infoContainer.backgroundColor = [UIColor darkRedColor];
    [self addSubview:_infoContainer];
    
    _tapView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tapView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _tapView.userInteractionEnabled = YES;
    [_tapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeader)]];
    [self addSubview:_tapView];
    
    NSDictionary *views = @{
                            @"titleView" : _titleView,
                            @"titleImage" : _titleImage,
                            @"infoContainer" : _infoContainer,
                            @"tap" : _tapView};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleImage]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleView(64)][titleImage]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[infoContainer]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-224-[infoContainer]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tap]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tap]|" options:0 metrics:nil views:views]];

}

- (UIView *)setupTitleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectZero];
    [titleView setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.text = @"Discovery";
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    [titleLable setTranslatesAutoresizingMaskIntoConstraints:NO];
    _hugeLabel = titleLable;
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
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    _title = title;
    [title setTranslatesAutoresizingMaskIntoConstraints:NO];
    title.font = [UIFont boldSystemFontOfSize:12];
    title.textColor = [UIColor whiteColor];
    title.text = @"咖啡基础知识集锦";
    [container addSubview:title];
    
    UILabel *auther = [[UILabel alloc] initWithFrame:CGRectZero];
    _auther = auther;
    [auther setTranslatesAutoresizingMaskIntoConstraints:NO];
    auther.font = [UIFont boldSystemFontOfSize:11];
    auther.textColor = [UIColor whiteColor];
    auther.text = @"李小宝";
    [container addSubview:auther];
    
    UILabel *brief = [[UILabel alloc] initWithFrame:CGRectZero];
    _brief = brief;
    [brief setTranslatesAutoresizingMaskIntoConstraints:NO];
    brief.font = [UIFont boldSystemFontOfSize:13];
    brief.textColor = [UIColor whiteColor];
    brief.text = @"李小宝制作的咖啡基础知识集锦";
    [container addSubview:brief];
    
    NSDictionary *views = @{@"title" : title,
                            @"auther" : auther,
                            @"brief" : brief};
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[title]" options:0 metrics:nil views:views]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[auther]" options:0 metrics:nil views:views]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[brief]" options:0 metrics:nil views:views]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[title(10)]-15-[auther(10)]-10-[brief]-|" options:0 metrics:nil views:views]];
    
    return container;
}

- (void)configHeaderWith:(NSString *)title articleTitle:(NSString *)articleTitle auther:(NSString *)auther brief:(NSString *)brief image:(NSURL *)image articleId:(NSString *)articleId {
    
    _articleId = articleId;
    _hugeLabel.text = title;
    [_titleImage sd_setImageWithURL:image];
    _title.text = articleTitle;
    _auther.text = auther;
    _brief.text = brief;
}

#pragma mark - tap action
- (void)tapHeader {
    if([_delegate respondsToSelector:@selector(tapHeaderWith:)]) {
        [_delegate tapHeaderWith:_articleId];
    }
}

@end
