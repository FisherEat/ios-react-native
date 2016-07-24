//
//  GLScrollListView.m
//  Demos
//
//  Created by gaolong on 16/7/24.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLScrollListView.h"

@implementation GLScrollListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addCollectionView];
    }
    return self;
}

- (void)addCollectionView
{
    [self addSubview:self.collectionView];
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[GLScrollListCell class] forCellWithReuseIdentifier:NSStringFromClass([GLScrollListCell class])];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GLScrollListCell *listCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GLScrollListCell class]) forIndexPath:indexPath];
    
    return listCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH / 2 - 20, 150);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [UIManager showViewControllerWithName:@"ScrollDemoVC"];
    }else if (indexPath.section == 0 && indexPath.row == 1) {
        [UIManager showViewControllerWithName:@""];
    }else {
        return;
    }
}

- (void)configView:(NSArray *)array
{
    [self.collectionView reloadData];
}

@end

@interface GLScrollListCell ()
@property (nonatomic, strong) UIImageView *adImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation GLScrollListCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.adImgView];
    [self.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:50.0];
    [self.adImgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.adImgView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.titleLabel];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.textColor = HEXCOLOR(0x222222);
        _titleLabel.font = APP_FONT_NORMAL;
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"这是一个collectioncell";
    }
    return _titleLabel;
}

- (UIImageView *)adImgView
{
    if (!_adImgView) {
        _adImgView = [UIImageView newAutoLayoutView];
        _adImgView.image = [UIImage imageNamed:@"xianlu"];
    }
    return _adImgView;
}

@end
