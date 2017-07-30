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
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor lightTextColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName ] = [UIColor whiteColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)setupSubViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    viewController.navigationItem.title = title;
    viewController.tabBarItem.title = title;
    
    if(!([image isEqualToString:@""] || image == nil)) {
        UIImage *darkImage;
        darkImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        viewController.tabBarItem.image = darkImage;
    }
    
    if(!([selectedImage isEqualToString:@""] || selectedImage == nil)) {
        UIImage *darkImage;
        darkImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        viewController.tabBarItem.selectedImage = darkImage;
    }
    
    CMNavigationController *navigationController = [[CMNavigationController alloc] initWithRootViewController:viewController];

    [self addChildViewController:navigationController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setBarTintColor:[UIColor darkBlueColor]];
    self.tabBar.tintColor = [UIColor whiteColor];
    
    [self setupSubViewController:[[CMHomeViewController alloc] init] title:@"发现" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupSubViewController:[[CMVideoListViewController alloc] init] title:@"视频" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    [self setupSubViewController:[[CMUserCenterViewController alloc] init] title:@"我的" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
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
