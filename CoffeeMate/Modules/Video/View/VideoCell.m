//
//  VideoCell.m
//  openEye
//
//  Created by 徐悟源 on 16/3/31.
//  Copyright © 2016年 Wuyuan. All rights reserved.
//

#import "VideoCell.h"
#import "CMVideoModule.h"
#import "UIImageView+WebCache.h"

#define Font_China(FontSize) [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:FontSize]
#define CellH ScreenSize.width * 0.6

@interface VideoCell()

@property (nonatomic, weak) UIImageView *bgView;

@property (nonatomic, weak) UIView *coverView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic , copy) NSString *typeAndTime;

@end

@implementation VideoCell

- (NSString *)typeAndTime
{
    if(!_typeAndTime)
    {
        self.typeAndTime = [[NSString alloc] init];
    }
    
    return _typeAndTime;
}

- (NSString *)timeWithSecondToString:(NSInteger)time
{
    NSInteger min = time / 60;
    NSInteger sec = time % 60;
    
    if(min < 10)
    {
        return [NSString stringWithFormat:@"0%ld' %ld''",(long)min,(long)sec];
    }
    
    return [NSString stringWithFormat:@"%ld' %ld''",(long)min,(long)sec];
}

- (void)setVideo:(CMVideoModule *)video
{
    _video = video;

    [self.bgView sd_setImageWithURL:video.coverUrl];
    
    self.titleLabel.text = video.title;
    
//    NSString *time = [self timeWithSecondToString:video.duration];
    _typeAndTime = [NSString stringWithFormat:@"#%@ / %@",video.title , @""];
    
    self.timeLabel.text = _typeAndTime;
}

- (instancetype)initWithTableView:(UITableView *)tableView
{
    VideoCell *cell = [VideoCell cellWithTableView:tableView];
    
    return cell;
}

+ (instancetype)cellWithTableView:(UITableView *)tebleView
{
    VideoCell *cell = [tebleView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if(!cell)
    {
        cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([self class])];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupVideoCell];
    }
    
    return self;
}

- (void)setupVideoCell
{
    UIImageView *bgView = [[UIImageView alloc] init];
    _bgView = bgView;
    _bgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgView];
    
    UIView *coverView = [[UIView alloc ]init];
    _coverView = coverView;
    _coverView.backgroundColor = [UIColor coverViewColor];
    [self.bgView addSubview:coverView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.font = Font_China(16);
    _titleLabel.textColor = [UIColor whiteColor];
    [self.coverView addSubview:titleLabel];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    _timeLabel = timeLabel;
    _timeLabel.font = Font_China(12);
    _timeLabel.textColor = [UIColor whiteColor];
    [self.coverView addSubview:timeLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat bgViewW = ScreenSize.width;
    CGFloat bgViewH = CellH;
    
    _bgView.my_Width = bgViewW;
    _bgView.my_Height = bgViewH;
    
    _coverView.frame = _bgView.frame;
    
    CGFloat titleLabelW = [self.video.title sizeWithFont:_titleLabel.font].width;
    
    CGFloat titleLabelH = [self.video.title sizeWithFont:_titleLabel.font].height;
    
    CGFloat titleLabelX = (self.bgView.my_Width - titleLabelW) / 2;
    CGFloat titleLabelY = (self.bgView.my_Height - titleLabelH) / 2;
    
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat typeAndTimeLabelW = [_typeAndTime sizeWithFont:_timeLabel.font].width;
    CGFloat typeAndTimeLabelH = [_typeAndTime sizeWithFont:_timeLabel.font].height;
    
    CGFloat typeAndTimeLabelX = (self.bgView.my_Width - typeAndTimeLabelW) / 2;
    
    CGFloat typeAndTimeLabelY = (self.bgView.my_Height - typeAndTimeLabelH) / 2 + 20;
    
    _timeLabel.frame = CGRectMake(typeAndTimeLabelX, typeAndTimeLabelY, typeAndTimeLabelW, typeAndTimeLabelH);
}

@end
