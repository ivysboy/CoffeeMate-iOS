//
//  CMHomeArticleCell.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/23.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMHomeArticleCell.h"
#import "UIImageView+AFNetworking.h"
#import <UIImage+ImageWithColor.h>

@interface CMHomeArticleCell()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *brief;

@end

@implementation CMHomeArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)configCellWith:(NSString *)title brief:(NSString *)brief image:(NSURL *)image {
    
    [_image setImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    _title.text = title;
    _brief.text = brief;
    [_image setImageWithURL:image];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
