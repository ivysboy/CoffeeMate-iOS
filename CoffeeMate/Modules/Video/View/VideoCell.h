//
//  VideoCell.h
//  openEye
//
//  Created by 徐悟源 on 16/3/31.
//  Copyright © 2016年 Wuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMVideoModule;

@interface VideoCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tebleView;

@property (nonatomic , strong) CMVideoModule *video;

@end
