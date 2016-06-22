//
//  GLPhotoCollectionViewController.m
//  Demos
//
//  Created by gaolong on 16/6/22.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLPhotoCollectionViewController.h"

@interface GLPhotoCollectionViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GLPhotoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topBarView.topBarStytle = GLTopBarStyleTitleLeftButtonRightButton;
    self.topBarView.titleText = @"CollectionViewLayout";
}

- (void)setUpViews
{
    
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:nil];
    }
}
- (void)topBarLeftButtonPressed:(UIButton *)button
{
    [UIManager backHome];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
