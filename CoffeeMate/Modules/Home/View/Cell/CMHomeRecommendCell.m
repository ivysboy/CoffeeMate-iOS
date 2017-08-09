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
#import "CMHomeContentArticle.h"

@interface CMHomeRecommendCell()<UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout,
                                CMRecommendInternalCellDelegate>

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
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
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

#pragma mark - UICollectionDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMRecommendInternalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CMRecommendInternalCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    CMHomeContentArticle *article = self.articles[indexPath.row];
    
    [cell configCellWith:article.image name:article.title title:article.auther brief:article.brief articleId:article.articleId];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CMHomeContentArticle *article = self.articles[indexPath.row];
    if([_delegate respondsToSelector:@selector(handleArticleItemClick:)]) {
        [_delegate handleArticleItemClick:article.articleId];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(RecommendCellWidth, RecommendCellHeight-44);
}

- (void)configCellWith:(NSArray <CMHomeContentArticle *> *)articles title:(NSString *)title {
    [_header configWith:title more:@"more" groupId:@""];
    [self.articles removeAllObjects];
    [self.articles addObjectsFromArray: articles];
    [self.collectionView reloadData];
}

- (void)touchCollectButton:(NSString *)articleId {
    if([_delegate respondsToSelector:@selector(collectActionAtArticle:)]) {
        [_delegate collectActionAtArticle:articleId];
    }
}
@end
