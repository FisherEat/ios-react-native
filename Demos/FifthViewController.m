//
//  FifthViewController.m
//  Demos
//
//  Created by schiller on 15/7/20.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "FifthViewController.h"
#import "Masonry.h"

@interface FifthViewController ()

@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    //[self setOneViewSize];
    //[self setTwoViewSize];
    [self setTwoViewSpiltSuperView];
   
}

- (void)setOneViewSize
{
    __weak typeof(self) weakSelf = self;
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:myView];
    
    [myView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 150));
        make.center.equalTo(weakSelf.view);
    }];
 
}

- (UIView *)setCustomView:(UIColor *)color
{
    UIView *blackView = [UIView new];
    blackView.backgroundColor = color;
    [self.view addSubview:blackView];
    
    return blackView;

}
- (void)setTwoViewSize
{

    UIView *blackView = [self setCustomView:[UIColor blackColor]];
    
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.and.top.mas_equalTo(20);
    }];
    
    UIView *grayView   = [self setCustomView:[UIColor grayColor]];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.and.top.equalTo(blackView);
        make.right.mas_equalTo(-20);
    }];
    
}

- (void)setTwoViewSpiltSuperView
{
     __weak typeof(self) weakSelf = self;
    UIView *blackView = [self setCustomView:[UIColor blackColor]];
    UIView *grayView  = [self setCustomView:[UIColor grayColor]];
    
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    
    }];
    
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.right.mas_equalTo(-20);
        make.height.equalTo(blackView);
        make.top.equalTo(blackView.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.view.mas_centerX).offset(0);

    }];
}

- (void)setTextFieldView
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
