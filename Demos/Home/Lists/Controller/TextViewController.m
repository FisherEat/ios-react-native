//
//  TextViewController.m
//  Demos
//
//  Created by gaolong on 15/8/12.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpCollectionView];
}

- (void)setUpCollectionView
{
    self.collectionView = [UICollectionView newAutoLayoutView];
    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
}

- (void)setUpConstraints
{
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64];
    [self.collectionView autoSetDimensionsToSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - self.navigationController.navigationBar.height)];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
