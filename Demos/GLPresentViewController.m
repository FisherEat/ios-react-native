//
//  GLPresentViewController.m
//  Demos
//
//  Created by gaolong on 15/8/27.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "GLPresentViewController.h"

@interface GLPresentViewController ()

@end

@implementation GLPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    self.topBarView.topBarStyle = TNTopBarStyleTitleWithLeftButton;
    self.topBarView.backgroundColor = [UIColor grayColor];
    self.topBarView.titleText = @"哈哈";
    [self setLeftButtonToBackButton];
    [self.view addSubview:self.topBarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
