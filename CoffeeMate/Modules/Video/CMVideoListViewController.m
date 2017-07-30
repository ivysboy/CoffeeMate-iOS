//
//  CMVideoListViewController.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/4.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMVideoListViewController.h"
#import "CMVideoDetailViewController.h"
#import "MJRefresh.h"
#import "VideoCell.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "AC_AVPlayerViewController.h"
#import "CMVideoModule.h"
#import "CMVideoDataManager.h"

#define CellH ScreenSize.width * 0.6

@interface CMVideoListViewController ()
@property (nonatomic , strong) NSMutableArray *dailyList;
@property (nonatomic , strong) CMVideoDataManager *dataManager;
@property (nonatomic , assign) int page;
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
    [self addRefresh];
    
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
    [self.dataManager fetchVideoListWith:parameter success:^(NSArray <CMVideoModule *>*data) {
        
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dailyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoCell *cell = [VideoCell cellWithTableView:tableView];
    CMVideoModule *video = self.dailyList[indexPath.row];
    [cell setVideo:video];
    return cell;
}

#pragma mark - header

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CMVideoModule *video = self.dailyList[indexPath.row];
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

@end
