//
//  GLButtonDemoViewController101.m
//  Demos
//
//  Created by gaolong on 16/2/8.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLButtonDemoViewController101.h"

@interface GLButtonDemoViewController101 ()

@end

@implementation GLButtonDemoViewController101

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTopBar];
}

- (void)setUpTopBar
{
    self.topBarView.topBarStytle = GLTopBarStyleTitleLeftButtonRightButton;
    self.topBarView.titleText = @"测试按钮页";
    self.topBarView.delegate = self;
    self.topBarView.rightButtonTitle = @"更多";
}

- (void)topBarLeftButtonPressed:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
