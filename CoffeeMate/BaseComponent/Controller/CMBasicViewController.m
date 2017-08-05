//
//  CMBasicViewController.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/5.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMBasicViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface CMBasicViewController ()

@end

@implementation CMBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLongToastWith:(NSString *)string {
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.detailsLabel.text = string;
    hub.detailsLabel.font = [UIFont systemFontOfSize:13];
    [hub hideAnimated:YES afterDelay:1.2];
}

- (void)showToastWith:(NSString *)string {
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.label.text = string;
    [hub hideAnimated:YES afterDelay:1.2];
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
