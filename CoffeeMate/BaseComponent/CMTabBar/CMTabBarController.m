//
//  CMTabBarController.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/4.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMTabBarController.h"
#import "CMHomeViewController.h"
#import "CMVideoListViewController.h"
#import "CMDiscoveryViewController.h"
#import "CMUserCenterViewController.h"
#import "CMNavigationController.h"

@interface CMTabBarController ()

@end

@implementation CMTabBarController

+ (void)initialize
{
    // 通过appearance统一设置所有的UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName ] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)setupSubViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    viewController.navigationItem.title = title;
    viewController.tabBarItem.title = title;
    
    if(!([image isEqualToString:@""] || image == nil)) {
        viewController.tabBarItem.image = [UIImage imageNamed:image];
    }
    
    if(!([selectedImage isEqualToString:@""] || selectedImage == nil)) {
        viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    
    CMNavigationController *navigationController = [[CMNavigationController alloc] initWithRootViewController:viewController];

    [self addChildViewController:navigationController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViewController:[[CMHomeViewController alloc] init] title:@"首页" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupSubViewController:[[CMVideoListViewController alloc] init] title:@"视频" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupSubViewController:[[CMDiscoveryViewController alloc] init] title:@"发现" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupSubViewController:[[CMUserCenterViewController alloc] init] title:@"我的" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
}


@end
