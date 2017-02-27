//
//  GLNativeTestViewController.m
//  rnToday_2
//
//  Created by gaolong on 16/4/2.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "GLNativeTestViewController.h"
#import "AppDelegate.h"
#import "GLReactViewController.h"

@interface GLNativeTestViewController ()

@property (nonatomic, strong) UIButton *pushButton;

@end

@implementation GLNativeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpButton];
}

- (void)setUpButton
{
  self.pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.pushButton setBackgroundColor:[UIColor redColor]];
  [self.pushButton setTitle:@"点击跳到ReactVC" forState:UIControlStateNormal];
  self.pushButton.layer.borderColor = [UIColor blackColor].CGColor;
  self.pushButton.layer.cornerRadius = 4;
  [self.pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  self.pushButton.titleLabel.font = [UIFont systemFontOfSize:16];
  [self.pushButton addTarget:self action:@selector(pushToReactVC) forControlEvents:UIControlEventTouchUpInside];
  self.pushButton.frame = CGRectMake(100, 200, 150, 40);
  
  [self.view addSubview:self.pushButton];
}

- (void)pushToReactVC
{
  GLReactViewController *reactVC = [GLReactViewController new];
  [[AppDelegate appDelegate].navigationController pushViewController:reactVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
