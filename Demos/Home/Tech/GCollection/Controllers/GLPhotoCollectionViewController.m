//
//  GLPhotoCollectionViewController.m
//  Demos
//
//  Created by gaolong on 16/6/22.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLPhotoCollectionViewController.h"

@interface GLPhotoCollectionViewController ()

@end

@implementation GLPhotoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topBarView.topBarStytle = GLTopBarStyleTitleLeftButtonRightButton;
    self.topBarView.titleText = @"CollectionViewLayout";
}

- (void)topBarLeftButtonPressed:(UIButton *)button
{
    [UIManager backHome];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
