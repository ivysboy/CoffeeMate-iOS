//
//  CMUserMainPageCell.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/2.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMUserMainPageCell.h"

@interface CMUserMainPageCell()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;


@end

@implementation CMUserMainPageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellWith:(NSString *)title subTitle:(NSString *)subTitle {
    _title.text = title;
    _subTitle.text = subTitle;
}

@end
