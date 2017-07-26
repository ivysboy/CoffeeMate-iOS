//
//  CMArticleContentViewController.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/23.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMArticleContentViewController.h"

@interface CMArticleContentViewController ()<UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *scrollView;

@end

@implementation CMArticleContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (UIScrollView *)scrollView {
    if(_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    
    return _scrollView;
}

- (void)setupSubView {
    
    UIImageView *mainImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.scrollView addSubview:mainImage];
    
    
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

@end
