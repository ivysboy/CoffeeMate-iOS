//
//  CMMoreVideoListViewController.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/8.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMMoreVideoListViewController.h"
#import "CMVideoModule.h"
#import "VideoCell.h"
#import "CMVideoDataManager.h"
#define CellH ScreenSize.width * 0.6

@interface CMMoreVideoListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray<CMVideoModule *> *videos;
@property (nonatomic , strong) CMVideoDataManager *dataManager;

@end

@implementation CMMoreVideoListViewController

- (CMVideoDataManager *)dataManager {
    if(!_dataManager) {
        _dataManager = [[CMVideoDataManager alloc] init];
    }
    return _dataManager;
}

- (NSMutableArray<CMVideoModule *> *)videos {
    if(!_videos) {
        _videos = [NSMutableArray array];
    }
    
    return _videos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
    [self getVideos];
}

- (void)setupSubViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    _tableView.dataSource = self;
    _tableView.delegate = self;

    [_tableView registerClass:[VideoCell class] forCellReuseIdentifier:NSStringFromClass([VideoCell class])];
    NSDictionary *views = @{@"tableView" : _tableView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views]];

}

- (void)getVideos {
    NSDictionary *paras = @{@"page" : @1,
                            @"groupId" : _groupId};
    [self.dataManager fetchVideoListWith:paras success:^(NSArray <CMVideoModule *>* data) {
        [self.videos addObjectsFromArray:data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoCell class]) forIndexPath:indexPath];
    CMVideoModule *item = self.videos[indexPath.row];
    cell.video = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellH;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
