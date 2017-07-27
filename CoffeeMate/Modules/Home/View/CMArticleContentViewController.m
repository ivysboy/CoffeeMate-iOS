//
//  CMArticleContentViewController.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/23.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMArticleContentViewController.h"
#import "CMHomeDataManager.h"
#import "CMHomeArticle.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface CMArticleContentViewController ()<UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIImageView *mainImage;
@property (nonatomic , strong) UILabel *content;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) CMHomeDataManager *dataManager;

@end

@implementation CMArticleContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubView];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (CMHomeDataManager *)dataManager {
    if(_dataManager == nil) {
        _dataManager = [[CMHomeDataManager alloc] init];
    }
    return _dataManager;
}

- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
        _scrollView.contentSize = CGSizeMake(ScreenSize.width, ScreenSize.height);
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    }
    
    return _scrollView;
}

- (void)setupSubView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *mainImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _mainImage = mainImage;
    [mainImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView addSubview:_mainImage];
    
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectZero];
    _content = content;
    [content setTranslatesAutoresizingMaskIntoConstraints:NO];
    _content.lineBreakMode = NSLineBreakByWordWrapping;
    _content.numberOfLines = 0;
    [self.scrollView addSubview:_content];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    _titleLabel.clipsToBounds = YES;
    _titleLabel.layer.cornerRadius = 10;
    _titleLabel.backgroundColor = [UIColor viewBackgroundColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:_titleLabel];
    
    NSDictionary *views = @{@"mainImage" : _mainImage, @"content" : _content, @"title" : _titleLabel};
    NSDictionary *metrics = @{@"width" : @(ScreenSize.width)};
    
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mainImage]|" options:0 metrics:metrics views:views]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.mainImage attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[content]|" options:0 metrics:metrics views:views]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainImage(240)]-60-[content]|" options:0 metrics:nil views:views]];
    [self.scrollView setContentSize:CGSizeMake(ScreenSize.width, ScreenSize.height)];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[title]-30-|" options:0 metrics:nil views:views]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.mainImage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:-20]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[title(40)]" options:0 metrics:nil views:views]];
    
}

- (void)loadData {
    
    NSDictionary *param = @{@"articleId" : _articleId};
    [self.dataManager fetchArticleWithParameter:param success:^(CMHomeArticle *data) {
        [_mainImage setImageWithURL:data.image];
        _content.text = data.content;
        self.title = data.name;
        _titleLabel.text = data.brief;
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

@end
