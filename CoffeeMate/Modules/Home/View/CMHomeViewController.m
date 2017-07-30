//
//  CMHomeViewController.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/4.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMHomeViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "CMHomeCycleView.h"
#import "CMHomeDataManager.h"
#import "CMHomeArticle.h"
#import "CMHomeArticleCell.h"
#import "MJRefresh.h"
#import "CMArticleContentViewController.h"
#import "CMHomeHeaderView.h"

#import "CMHomeRecommendCell.h"
#import "CMHomeBanner.h"
#import "CMHomeContentArticle.h"
#import "CMHomeContent.h"
#import "UIDevice+UUID.h"

#define CYCLEVIEWHEIGHT [UIScreen mainScreen].bounds.size.width / 375 * 172
#define HEADERHEIGHT 320

@interface CMHomeViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,
                                   CMHomeRecommendCellDelegate, CMHomeHeaderViewDelegate>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSMutableArray <CMHomeContent *>*articles;

@property (nonatomic , strong) CMHomeDataManager *dataManager;

@property (nonatomic , strong) MJRefreshNormalHeader *pullRefreshHeader;

@property (nonatomic , assign) int page;

@property (nonatomic , strong) UIView *titleView;

@property (nonatomic , strong) CMHomeHeaderView *headerView;

@end

@implementation CMHomeViewController

- (NSMutableArray *)articles {
    if(_articles == nil) {
        _articles = [NSMutableArray array];
    }
    
    return _articles;
}

- (CMHomeDataManager *)dataManager {
    if(_dataManager == nil) {
        _dataManager = [[CMHomeDataManager alloc] init];
    }
    return _dataManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uploadDeviceInfo];
    [self setupNavigationBar];
    [self setupSubView];

    [self beginRefreshing];
}

- (void)uploadDeviceInfo {
    NSString *proVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *sysVersion = [NSString stringWithFormat:@"%@ %@" , [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
    NSString *terminalVersion = [[UIDevice currentDevice] model];
    
    NSDictionary *info = @{@"deviceId" : [[UIDevice currentDevice] UUID],
                           @"devicePlatform" : terminalVersion,
                           @"systemVersion" : sysVersion,
                           @"prodVersion" : proVersion
                           };
    [self.dataManager postDeviceInfoWith:info success:^(id data) {
        NSLog(@"%@", data);
    } failure:^(NSError *error) {
        
    }];
}

- (void)setNeedReresh {
    self.pullRefreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginRefreshing)];
    self.tableView.mj_header = _pullRefreshHeader;
}

- (void)setLoadMore
{
    MJRefreshAutoNormalFooter *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNext)];
    refreshFooter.automaticallyHidden = YES;
    self.tableView.mj_footer = refreshFooter;
}

- (void)beginRefreshing {
    [self.tableView.mj_footer resetNoMoreData];
    _page = 1;
    [self queryHomeBanner];
    [self queryContentList];
}

- (void)queryHomeBanner {
    [self.dataManager fetchHomeBannerWithParameter:nil success:^(CMHomeBanner *data) {

        UILabel *title = (UILabel *)self.navigationItem.titleView;
        [_headerView configHeaderWith:title.text articleTitle:data.title auther:data.auther brief:data.brief image:data.image articleId:data.articleId];
    } failure:^(NSError *error) {
        
    }];
}

- (void)queryContentList {
    [self.dataManager fetchHomeContentListWithParameter:nil success:^(NSArray <CMHomeContent *> *data) {
        if(_page == 1) {
            [self.articles removeAllObjects];
        }
        [self.articles addObjectsFromArray:data];
        [self.tableView reloadData];
        [_pullRefreshHeader endRefreshing];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadNext {
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)setupNavigationBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(ScreenSize.width, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UIButton *searchBtn = [self customViewWithImage:[UIImage imageNamed:@"icon-redact"]];
    searchBtn.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *searchBarButton = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    UIButton *categoryBtn = [self customViewWithImage:[UIImage imageNamed:@"icon_all-categories"]];
    categoryBtn.frame = CGRectMake(0, 0, 20, 20);
    [categoryBtn setBackgroundImage:[UIImage imageNamed:@"icon_all-categories"] forState:UIControlStateNormal];
    UIBarButtonItem *categoryBarButton = [[UIBarButtonItem alloc] initWithCustomView:categoryBtn];
    
    UIBarButtonItem *negativeRightSpacer1 = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil action:nil];
    negativeRightSpacer1.width = 5;
    UIBarButtonItem *negativeRightSpacer2 = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                             target:nil action:nil];
    negativeRightSpacer2.width = 25;
    
    self.navigationItem.rightBarButtonItems = @[negativeRightSpacer1, searchBarButton, negativeRightSpacer2, categoryBarButton];
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.text = @"Discovery";
    titleView.font = [UIFont boldSystemFontOfSize:13];
    titleView.textAlignment = NSTextAlignmentCenter;
    CGFloat titleWidth = [titleView.text boundingRectWithSize:CGSizeMake(ScreenSize.width / 3, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : titleView.font} context:nil].size.width;
    CGSize titleSize = CGSizeMake(titleWidth + 50, 30);
    [titleView setFrame:CGRectMake(0, 0, titleSize.width, titleSize.height)];
    [self.navigationItem setTitleView:titleView];
    
    _titleView = self.navigationItem.titleView;
    _titleView.alpha = 0.f;
}

- (void)setupSubView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor viewBackgroundColor];
    [_tableView registerClass:[CMHomeRecommendCell class] forCellReuseIdentifier:NSStringFromClass([CMHomeRecommendCell class])];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [self.view addSubview:_tableView];
    
    [self setNeedReresh];
    [self setLoadMore];
    
    NSDictionary *views = @{@"tableView": _tableView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views]];
    
    
    CMHomeHeaderView *header = [[CMHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, HEADERHEIGHT)];
    _headerView = header;
    _headerView.delegate = self;
    _tableView.tableHeaderView = header;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CMHomeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CMHomeRecommendCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    CMHomeContent *content = self.articles[indexPath.row];
    [cell configCellWith: content.articleList title:content.title];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RecommendCellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self changeTitleViewAlpha:scrollView.contentOffset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self changeTitleViewAlpha:scrollView.contentOffset];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self changeTitleViewAlpha:scrollView.contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeTitleViewAlpha:scrollView.contentOffset];
}

- (void)changeTitleViewAlpha:(CGPoint) contenOffset {
    if(contenOffset.y > 64) {
        _titleView.alpha = 1.0f;
        return;
    }
    
    _titleView.alpha = contenOffset.y /64;
}

- (UIButton *)customViewWithImage:(UIImage *)image {
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    [customView setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    customView.exclusiveTouch = YES;
    customView.frame = CGRectMake(0, 0, 44, 44);
    
    UIImage *darkImage;
    darkImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    customView.tintColor = [UIColor darkGrayColor];
    
    [customView setImage:darkImage forState:UIControlStateNormal];
    CGRect frame = customView.frame;
    frame.size.width = image.size.width;
    customView.frame = frame;
    return customView;
}

#pragma mark - CMHomeRecommendCellDelegate
- (void)handleArticleItemClick:(NSString *)articleId {
    CMArticleContentViewController *content = [[CMArticleContentViewController alloc] init];
    content.articleId = articleId;
    [self.navigationController pushViewController:content animated:YES];
}

#pragma mark - CMHomeHeaderViewDelegate
- (void)tapHeaderWith:(NSString *)articleId {
    CMArticleContentViewController *content = [[CMArticleContentViewController alloc] init];
    content.articleId = articleId;
    [self.navigationController pushViewController:content animated:YES];
}

@end
