//
//  CMUserCenterViewController.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/4.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMUserCenterViewController.h"
#import "CMUserHeaderView.h"
#import "CMUserMainPageCell.h"

@interface CMUserCenterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray <NSString *>*content;

@end

@implementation CMUserCenterViewController

- (NSMutableArray *)content {
    if(!_content) {
        _content = [NSMutableArray array];
    }
    return _content;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
    [_content addObjectsFromArray:@[@"我的收藏", @"意见反馈", @"给个好评鼓励一下！", @"当前版本"]];
}

- (void)setupSubViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor viewBackgroundColor];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CMUserMainPageCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CMUserMainPageCell class])];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    CMUserHeaderView *header = [[CMUserHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 220)];
    _tableView.tableHeaderView = header;
    
    
    NSDictionary *views = @{@"tableView" : _tableView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMUserMainPageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CMUserMainPageCell class]) forIndexPath:indexPath];
    NSString *title = self.content[indexPath.row];
    [cell configCellWith:title subTitle:@""];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
