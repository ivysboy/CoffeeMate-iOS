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

@interface CMArticleContentViewController ()<UIScrollViewDelegate, UIWebViewDelegate>

@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIImageView *mainImage;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) CMHomeDataManager *dataManager;
@property (nonatomic , strong) UIWebView *contentView;
@property (nonatomic , strong) NSLayoutConstraint *heightContraints;

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
    
    _contentView = [[UIWebView alloc] initWithFrame:CGRectZero];
    [_contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _contentView.delegate = self;
    _contentView.scrollView.scrollEnabled = NO;
    [self.scrollView addSubview:_contentView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    _titleLabel.clipsToBounds = YES;
    _titleLabel.layer.cornerRadius = 10;
    _titleLabel.backgroundColor = [UIColor viewBackgroundColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:_titleLabel];
    
    NSDictionary *views = @{@"mainImage" : _mainImage, @"content" : _contentView, @"title" : _titleLabel};
    NSDictionary *metrics = @{@"width" : @(ScreenSize.width)};
    
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mainImage]|" options:0 metrics:metrics views:views]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.mainImage attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[content]|" options:0 metrics:metrics views:views]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainImage(240)]-60-[content]-40-|" options:0 metrics:nil views:views]];
    [self.scrollView setContentSize:CGSizeMake(ScreenSize.width, ScreenSize.height)];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[title]-30-|" options:0 metrics:nil views:views]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.mainImage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:-20]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[title(40)]" options:0 metrics:nil views:views]];
    _heightContraints = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:30];
    [self.scrollView addConstraint:_heightContraints];
    
}

- (void)loadData {
    
    NSDictionary *param = @{@"articleId" : _articleId};
    [self.dataManager fetchArticleWithParameter:param success:^(CMHomeArticle *data) {
        [_mainImage setImageWithURL:data.image];
        self.title = data.name;
        _titleLabel.text = data.brief;
        [self loadContent:data.content];
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}


- (void)loadContent:(NSString *)content {
    [_contentView loadHTMLString:[self basicHTMLBody:content] baseURL:[[NSBundle mainBundle] bundleURL]];
}

- (NSString *)basicHTMLBody:(NSString *)content {
    
    return [NSString stringWithFormat:@"<html><head><style>%@</style></head><body><div id='box_web_content'>%@</div></body></html>" , [self css],content];
    
}

- (NSString *)css {
    return @"* {font-family: Helvetica;word-break: break-all;}   p {color: #646464;} p.listitem{ padding-left:10px;}p.listitem:before { position:absolute;left:2px;}";
}

#pragma mark --- WebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _heightContraints.constant = webView.scrollView.contentSize.height + 20.0;
}

@end
