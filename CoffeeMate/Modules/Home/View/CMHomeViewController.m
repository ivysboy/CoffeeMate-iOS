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

#define CYCLEVIEWHEIGHT [UIScreen mainScreen].bounds.size.width / 375 * 172

@interface CMHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *articles;

@property (nonatomic , strong) CMHomeDataManager *dataManager;

@property (nonatomic , strong) MJRefreshNormalHeader *pullRefreshHeader;

@property (nonatomic , assign) int page;

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

- (void)setupSubView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CMHomeArticleCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CMHomeArticleCell class])];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [self.view addSubview:_tableView];
    
    [self setNeedReresh];
    [self setLoadMore];
    
    NSDictionary *views = @{@"tableView": _tableView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views]];
    
    CMHomeCycleView *cycleView = [[CMHomeCycleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CYCLEVIEWHEIGHT)];
    _tableView.tableHeaderView = cycleView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMHomeArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CMHomeArticleCell class]) forIndexPath:indexPath];

    
    
    
    CMHomeArticle *article = self.articles[indexPath.row];
    [cell configCellWith:article.name brief:article.brief image:article.image];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
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


@end
