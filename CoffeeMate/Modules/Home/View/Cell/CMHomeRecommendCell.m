//
//  CMHomeRecommendCell.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/7/27.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "CMHomeRecommendCell.h"
#import "CMRecommendCellHeader.h"
#import "CMRecommendInternalCell.h"
#import "CMHomeArticle.h"

@interface CMHomeRecommendCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) NSArray *items;
@property (nonatomic , strong) CMRecommendCellHeader *header;
@property (nonatomic , strong) NSMutableArray *articles;

@end

@implementation CMHomeRecommendCell

- (NSMutableArray *)articles {
    if(!_articles) {
        _articles = [NSMutableArray array];
    }
    
    return _articles;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.contentView.backgroundColor = [UIColor viewBackgroundColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    
    return self;
}

- (void)setupSubViews {
    _header = [[CMRecommendCellHeader alloc] initWithFrame:CGRectZero];
    [_header setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:_header];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.pagingEnabled = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor viewBackgroundColor];
    [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_collectionView registerClass:[CMRecommendInternalCell class] forCellWithReuseIdentifier:NSStringFromClass([CMRecommendInternalCell class])];
    
    
    [self.contentView addSubview:_collectionView];
    
    NSDictionary *views = @{@"collection" : _collectionView , @"head" : _header};
    NSDictionary *metrics = @{@"height" : @(RecommendCellHeight - 54) , @"headHeight" : @34};
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[head(headHeight)][collection]|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[head]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collection]|" options:0 metrics:nil views:views]];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.articles.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"press %@ cell", @(indexPath.row));
}


#pragma mark - UICollectionDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMRecommendInternalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CMRecommendInternalCell class]) forIndexPath:indexPath];

    CMHomeArticle *article = self.articles[indexPath.row];
    
    [cell configCellWith:article.image name:article.name title:@"Your title" brief:article.brief];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSLog(@"%@",_items[indexPath.row].name);
//    SecKillGoodItem *item = _items[indexPath.row];
//    
//    NSTimeInterval timeGap = [[NSDate date]timeIntervalSince1970] - _configTimeInterval;
//    
//    JPTimerData *timerData = [[JPTimerData alloc] initWithTimerDataWith:item.startTime > 0 ? item.startTime.longLongValue / 1000 - timeGap : 0 endTime:item.endTime > 0 ? item.endTime.longLongValue / 1000 - timeGap : 0];
//    
//    SecKillCell *secCell = (SecKillCell *)cell;
//    [secCell updateTimeData:timerData];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(RecommendCellWidth, RecommendCellHeight-54);
}

- (void)configCellWith:(NSArray <CMHomeArticle *> *)articles {
    [self.articles addObjectsFromArray: articles];
    [self.collectionView reloadData];
}
@end