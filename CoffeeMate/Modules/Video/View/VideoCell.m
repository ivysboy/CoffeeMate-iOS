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
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setupVideoCell];
    }
    
    return self;
}

- (void)setupVideoCell
{
    UIImageView *bgView = [[UIImageView alloc] init];
    [bgView setTranslatesAutoresizingMaskIntoConstraints: NO];
    _bgView = bgView;
    _bgView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:bgView];
    
    UIView *coverView = [[UIView alloc ]init];
    [coverView setTranslatesAutoresizingMaskIntoConstraints: NO];
    _coverView = coverView;
    _coverView.backgroundColor = [UIColor coverViewColor];
    [self.bgView addSubview:coverView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    _titleLabel = titleLabel;
    _titleLabel.font = Font_China(16);
    _titleLabel.textColor = [UIColor whiteColor];
    [self.coverView addSubview:titleLabel];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    [timeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    _timeLabel = timeLabel;
    _timeLabel.font = Font_China(12);
    _timeLabel.textColor = [UIColor whiteColor];
    [self.coverView addSubview:timeLabel];
    
    NSDictionary *views = @{@"bgView" : _bgView,
                            @"cover" : _coverView,
                            @"title" : _titleLabel,
                            @"time" : _timeLabel};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bgView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bgView]|" options:0 metrics:nil views:views]];
    [self.bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cover]|" options:0 metrics:nil views:views]];
    [self.bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cover]|" options:0 metrics:nil views:views]];
    [self.coverView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[title]" options:0 metrics:0 views:views]];
    [self.coverView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.coverView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.coverView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.coverView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.coverView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[title]-10-[time]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    
}

@end
