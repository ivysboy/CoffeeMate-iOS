//
//  CMHomeCycleView.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMHomeCycleView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface CMHomeCycleView()<SDCycleScrollViewDelegate>

@property (nonatomic , strong) SDCycleScrollView *cycleView;

@end

@implementation CMHomeCycleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _cycleView = [[SDCycleScrollView alloc] initWithFrame:CGRectZero];
        [_cycleView setTranslatesAutoresizingMaskIntoConstraints:NO];
        _cycleView.delegate = self;
        _cycleView.autoScrollTimeInterval = 3.0;
        _cycleView.pageControlAliment = SDCycleScrollViewPageContolStyleAnimated;
        _cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        [self addSubview:_cycleView];
        
        NSDictionary *views = @{@"cycleView": _cycleView};
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cycleView]|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cycleView]|" options:0 metrics:nil views:views]];
        
        NSArray <NSString *>*array = @[@"http://pic36.nipic.com/20131128/8821914_102603837000_2.jpg",
                                       @"http://pic.jj20.com/up/allimg/211/041911150557/110419150557-1.jpg",
                                       @"http://s9.knowsky.com/bizhi/l/35001-45000/200952904241438473283.jpg"];
        _cycleView.imageURLStringsGroup = array;
        
    }
    
    return self;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"你点击了第%@张图片", @(index));
}


@end
