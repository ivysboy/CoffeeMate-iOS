//
//  CMVideoListViewController.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/4.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMVideoListViewController.h"
#import "MJRefresh.h"
#import "VideoCell.h"
#import "AC_AVPlayerViewController.h"
#import "CMVideoModule.h"
#import "CMVideoGroupModule.h"
#import "CMVideoDataManager.h"
#import "CMRecommendCellHeader.h"
#import "CMMoreVideoListViewController.h"

#define CellH ScreenSize.width * 0.6

@interface CMVideoListViewController ()<UITableViewDelegate, UITableViewDataSource, CMRecommendCellHeaderDelegate>
@property (nonatomic , strong) NSMutableArray <CMVideoGroupModule *> *dailyList;
@property (nonatomic , strong) CMVideoDataManager *dataManager;
@property (nonatomic , assign) int page;
@property (nonatomic , strong) UITableView *tableView;
@end

@implementation CMVideoListViewController

- (CMVideoDataManager *)dataManager {
    if(!_dataManager) {
        _dataManager = [[CMVideoDataManager alloc] init];
    }
    
    return _dataManager;
}

- (NSMutableArray *)dailyList
{
    if(!_dailyList)
    {
        _dailyList = [NSMutableArray array];
    }
    return _dailyList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.tableView];
    NSDictionary *views = @{@"tableView" : self.tableView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self addRefresh];
    [self.tableView registerClass:[VideoCell class] forCellReuseIdentifier:NSStringFromClass([VideoCell class])];
    [self.tableView registerClass:[CMRecommendCellHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([CMRecommendCellHeader class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)addRefresh
{
    // 添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginRefreshing)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerWithRefreshingMore)];
    
}

- (void)beginRefreshing {
    [self.tableView.mj_footer resetNoMoreData];
    _page = 1;
    [self queryVideoList];
}

- (void)queryVideoList {
    NSDictionary *parameter = @{@"page" : @(_page)};
    [self.dataManager fetchMainVideoListWith:parameter success:^(NSArray <CMVideoGroupModule *>*data) {
        
        if(_page == 1) {
            [self.dailyList removeAllObjects];
        }
        
        [self.dailyList addObjectsFromArray:data];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if(data.count < 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)footerWithRefreshingMore {
    _page++;
    [self queryVideoList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dailyList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CMVideoGroupModule *videoGroup = self.dailyList[section];
    NSArray <CMVideoModule *> *videos = videoGroup.videos;
    return videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoCell class]) forIndexPath:indexPath];
    CMVideoGroupModule *videoGroup = self.dailyList[indexPath.section];
    NSArray <CMVideoModule *> *videos = videoGroup.videos;
    CMVideoModule *video = videos[indexPath.row];
    [cell setVideo:video];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CMRecommendCellHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([CMRecommendCellHeader class])];
    header.delegate = self;
    CMVideoGroupModule *videoGroup = self.dailyList[section];
    [header configWith:videoGroup.title more:@"more" groupId:videoGroup.groupId];
    return header;
}

#pragma mark - header

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMVideoGroupModule *videoGroup = self.dailyList[indexPath.section];
    NSArray <CMVideoModule *> *videos = videoGroup.videos;
    CMVideoModule *video = videos[indexPath.row];
    
    AC_VideoModel *model1 = [[AC_VideoModel alloc] initWithName:video.title url:video.videoUrl];
    
    AC_AVPlayerViewController *ctr = [[AC_AVPlayerViewController alloc] initWithVideoList:@[model1]];

    [self presentViewController:ctr animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CATransform3D transform;
    
    transform = CATransform3DMakeTranslation(0 ,5 ,10);
    
    transform = CATransform3DScale(transform, 0.98, 0.98, 1);
    
    transform.m34 = -1.0/ 600;
    
    cell.layer.shadowColor = [[UIColor whiteColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(5, 5);
    cell.layer.transform = transform;
    cell.alpha = 0.9;
    
    [UIView beginAnimations:@"transform" context:NULL];
    
    [UIView setAnimationDuration:0.6];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

#pragma mark -- header delegate
- (void)clickForMore:(NSString *)groupId {
    CMMoreVideoListViewController *moreViewController = [[CMMoreVideoListViewController alloc] init];
    moreViewController.groupId = groupId;
    for(CMVideoGroupModule *group in self.dailyList) {
        if([group.groupId isEqualToString:groupId]) {
            moreViewController.title = group.title;
            break;
        }
    }

    [self.navigationController pushViewController:moreViewController animated:YES];
}

@end
