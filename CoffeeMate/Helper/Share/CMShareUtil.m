//
//  CMShareUnit.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMShareUtil.h"
#import "CMShareItemCell.h"
#import "WeiboSDK.h"
#import <objc/runtime.h>
#import "CMShareItem.h"
#import <WechatOpenSDK/WXApi.h>

static NSString *const kShareReusableIdentifier = @"ShareReusableIdentifier";

static CGFloat  kShareHeight = 150.0;

@interface CMShareUtil ()<UICollectionViewDelegate ,UICollectionViewDataSource>

@property (nonatomic , strong) UIView *backgroundView;
@property (nonatomic , strong) UIView *disMissView;
@property (nonatomic , strong) UIView *containerView;

@property (nonatomic , strong) UICollectionView *collectionView;

@property (nonatomic , strong) NSLayoutConstraint *positionContraint;

@property (nonatomic , strong) NSArray *shareItems;


@end

@implementation CMShareUtil


+ (BOOL)canShare {
    return [WXApi isWXAppInstalled];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

- (char *)containerKey {
    return "CMShareUtilContainerKey";
}


- (NSArray <__kindof CMShareItem *> *)allShareTypes {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    
    if ([WXApi isWXAppInstalled]){
        [array addObject:[CMShareItem shareItemWithTitle:@"微信好友" type:CMShareTypeWXSession icon:@"thirdparty-wx"]];
        [array addObject:[CMShareItem shareItemWithTitle:@"朋友圈" type:CMShareTypeWXTimeline icon:@"thirdparty-wx-timeline"]];
    }
    
    if ([WeiboSDK isWeiboAppInstalled]){
        [array addObject:[CMShareItem shareItemWithTitle:@"新浪微博" type:CMShareTypeSinaTimeline icon:@"thirdparty-wb"]];
        
    }

    
    return [NSArray arrayWithArray:array];
}

- (void)setupCollectionView {
    self.shareItems = [self allShareTypes];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 15.0;
    flowLayout.minimumInteritemSpacing = 0.0;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width  / 4;
    CGFloat height = 65.0;
    flowLayout.itemSize = CGSizeMake(width, height);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_collectionView registerClass:[CMShareItemCell class] forCellWithReuseIdentifier:kShareReusableIdentifier];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
}

- (BOOL)showShareUtil {
    
    if(![[self class] canShare]) {
        if ([_delegate respondsToSelector:@selector(shareUtil:cancelShare:)]) {
            [_delegate shareUtil:self cancelShare:YES];
        }
        return NO;
    }
    
    NSDictionary *metrics = @{@"height" : @(kShareHeight)};
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    [_backgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    _backgroundView.backgroundColor = [UIColor clearColor];
    [window addSubview:_backgroundView];
    
    objc_setAssociatedObject(self.backgroundView, [self containerKey], self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [window addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backgroundView]|" options:0 metrics:nil views:@{@"_backgroundView" : _backgroundView}]];
    [window addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backgroundView]|" options:0 metrics:nil views:@{@"_backgroundView" : _backgroundView}]];
    
    _disMissView = [[UIView alloc] initWithFrame:CGRectZero];
    self.disMissView = [[UIView alloc] initWithFrame:CGRectZero];
    [_disMissView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_disMissView setBackgroundColor:[UIColor colorWithWhite:0 alpha:.3f]];
    [_backgroundView addSubview:_disMissView];
    //
    self.containerView = [[UIView alloc] initWithFrame:CGRectZero];
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    [_containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_backgroundView addSubview:_containerView];
    [self setupCollectionView];
    //
    //
    NSDictionary *views = NSDictionaryOfVariableBindings(_backgroundView , _containerView , _disMissView);
    
    [_backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_disMissView][_containerView]" options:0 metrics:nil views:views]];
    [_backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_disMissView]|" options:0 metrics:nil views:views]];
    [_backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_containerView]|" options:0 metrics:nil views:views]];
    
    [_backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_containerView(height)]" options:0 metrics:metrics views:views]];
    
    [self configCollectionView];
    
    
    
    //
    NSLayoutConstraint *contraint = [NSLayoutConstraint constraintWithItem:_containerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_backgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kShareHeight];
    [_backgroundView addConstraint:contraint];
    self.positionContraint = contraint;
    
    [self performSelector:@selector(animateForShow) withObject:nil afterDelay:0.0];
    return YES;
}

- (void)configCollectionView {
    [_containerView addSubview:_collectionView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    [title setTranslatesAutoresizingMaskIntoConstraints:NO];
    [title setFont:[UIFont systemFontOfSize:13]];
    [title setTextColor:[UIColor darkBlueColor]];
    [title setText:@"分享到"];
    [_containerView addSubview:title];
    
    UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horizonal-line"]];
    [line setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_containerView addSubview:line];
    
    
    NSDictionary * views = NSDictionaryOfVariableBindings(_collectionView , title , line);
    NSDictionary * metrics = @{@"margin" : @10 };
    
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[title]-margin-|" options:0 metrics:metrics views: views]];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[line]-margin-|" options:0 metrics:metrics views: views]];
    
    
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:metrics views: views]];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:metrics views: views]];
    
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[title]-margin-[line(1)][_collectionView]|" options:0 metrics:metrics views: views]];
}

- (void)dissmiss {
    [self animateForHide];
    objc_setAssociatedObject(self.backgroundView, [self containerKey], nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (void)animateForShow {
    [self updateContraint:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [_backgroundView layoutIfNeeded];
    } completion:^(BOOL finished) {
        _backgroundView.backgroundColor  = [UIColor colorWithWhite:0 alpha:.3f];
        [_disMissView setBackgroundColor:[UIColor clearColor]];
        [_disMissView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideShareView:)]];
    }];
}
- (void)animateForHide {
    [self updateContraint:NO];
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        _backgroundView.backgroundColor  = [UIColor clearColor];
        [_backgroundView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [_containerView removeFromSuperview];
        [_backgroundView removeFromSuperview];
    }];
}

- (void)updateContraint:(BOOL)show {
    CGFloat height = show ? 0 : kShareHeight;
    self.positionContraint.constant = height;
}



- (void)hideShareView:(id )sender {
    
    if ([_delegate respondsToSelector:@selector(shareUtil:cancelShare:)]) {
        [_delegate shareUtil:self cancelShare:YES];
    }
    
    [self dissmiss];
}



#pragma mark --- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(shareUtil:didSelectType:)]) {
        CMShareItem *item = _shareItems[indexPath.row];
        [_delegate shareUtil:self didSelectType:item.type];
    }
    [self dissmiss];
}

#pragma mark --- UICollectionViewDataSource


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMShareItemCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:kShareReusableIdentifier forIndexPath:indexPath];
    CMShareItem *shareItem = _shareItems[indexPath.row];
    [cell updateCellWith:shareItem.title image:shareItem.icon];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_shareItems count];
}

@end
