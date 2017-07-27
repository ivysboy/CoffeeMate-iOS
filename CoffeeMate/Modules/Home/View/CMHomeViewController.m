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

#define CYCLEVIEWHEIGHT [UIScreen mainScreen].bounds.size.width / 375 * 172
#define HEADERHEIGHT 320

@interface CMHomeViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *articles;

@property (nonatomic , strong) CMHomeDataManager *dataManager;

@property (nonatomic , strong) MJRefreshNormalHeader *pullRefreshHeader;

@property (nonatomic , assign) int page;

@property (nonatomic , strong) UIView *titleView;

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
    [self setupNavigationBar];
    [self setupSubView];

    [self beginRefreshing];
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
    [self getArticles];
}

- (void)loadNext {
    _page++;
    [self getArticles];
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
    _tableView.tableHeaderView = header;
//    
//    CMHomeCycleView *cycleView = [[CMHomeCycleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CYCLEVIEWHEIGHT)];
//    _tableView.tableHeaderView = cycleView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CMHomeRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CMHomeRecommendCell class]) forIndexPath:indexPath];

    [cell configCellWith:self.articles];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RecommendCellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CMArticleContentViewController *contentController = [[CMArticleContentViewController alloc] init];
    CMHomeArticle *item = self.articles[indexPath.row];
    contentController.articleId = item.articleId;
    [self.navigationController pushViewController:contentController animated:YES];
}

#pragma mark - data request

- (void)getArticles {
    
    NSDictionary *params = @{@"page" : @(_page) ,
                             @"orderBy" : @"-createtime"};
   [self.dataManager fetchArticlesListWithParameters:params success:^(NSArray *data) {
       [_pullRefreshHeader endRefreshing];
       if([data count] < 10) {
           [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
       }
       if(_page == 1) {
           [self.articles removeAllObjects];
       }
       [self.articles addObjectsFromArray:data];
       [self.tableView reloadData];
       
    } failure:^(NSError *error) {
        [_pullRefreshHeader endRefreshing];
    }];
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


@end
