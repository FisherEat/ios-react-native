//
//  GLPhotoCollectionViewController.m
//  Demos
//
//  Created by gaolong on 16/6/22.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLPhotoCollectionViewController.h"
#import "GLPhotoFlowLayout.h"
#import "GLPhotoCollectionViewCell.h"

@interface GLPhotoCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) GLPhotoFlowLayout *flowLayout;

@end

@implementation GLPhotoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topBarView.topBarStytle = GLTopBarStyleTitleLeftButtonRightButton;
    self.topBarView.titleText = @"CollectionViewLayout";
    [self setUpViews];
}

- (void)setUpViews
{
    [self.view addSubview:self.collectionView];
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.collectionView autoSetDimension:ALDimensionHeight toSize:250.0];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _flowLayout = [[GLPhotoFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[GLPhotoCollectionViewCell class]
            forCellWithReuseIdentifier:NSStringFromClass([GLPhotoCollectionViewCell class])];
    }
    return _collectionView;
}

- (void)topBarLeftButtonPressed:(UIButton *)button
{
    [UIManager backHome];
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(320, 200);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GLPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GLPhotoCollectionViewCell class]) forIndexPath:indexPath];
    [cell bindModel:nil];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
