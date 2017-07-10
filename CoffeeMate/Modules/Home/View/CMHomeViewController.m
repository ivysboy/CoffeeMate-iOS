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

#define CYCLEVIEWHEIGHT [UIScreen mainScreen].bounds.size.width / 375 * 172

@interface CMHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic , strong) UITableView *tableView;

@end

@implementation CMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubView];
}

- (void)setupSubView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
@end
