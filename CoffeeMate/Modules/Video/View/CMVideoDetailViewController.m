
//
//  CMVideoDetailViewController.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/30.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMVideoDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "AC_AVPlayerViewController.h"


@interface CMVideoDetailViewController ()

@property (nonatomic , strong) AVPlayer *avPlayer;

@end

@implementation CMVideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSURL *url = [NSURL URLWithString:@"http://static.ivysboy.com/video/1.mp4"];
    AC_VideoModel *model1 = [[AC_VideoModel alloc] initWithName:@"点滴法手冲咖啡" url:url];
    
    AC_AVPlayerViewController *ctr = [[AC_AVPlayerViewController alloc] initWithVideoList:@[model1]];
    [self presentViewController:ctr animated:YES completion:^{
        
    }];

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
