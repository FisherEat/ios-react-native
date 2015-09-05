//
//  GLBarViewController.m
//  Demos
//
//  Created by schiller on 15/8/27.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "GLBarViewController.h"

@interface GLBarViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@end

@implementation GLBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTopBarView];
    
    //UINavigationControllerDelegate
    self.navigationController.delegate = self;
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

- (void)setupTopBarView
{
    [self.view addSubview:self.topBarView];
}

- (void)setLeftButtonToBackButton
{
    if (!self.topBarView.leftButton) {
        return;
    }
    
    self.topBarView.leftButtonImage = [UIImage imageNamed:@"icon_nav_back"];
    self.topBarView.leftButtonTitle = @"";
    self.topBarView.leftButton.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
    self.topBarView.leftButton.frame = CGRectMake(0, 20, 44, 44);
}

#pragma mark - Overrider getter
- (GLTopBarView *)topBarView
{
    if (!_topBarView) {
        _topBarView = [GLTopBarView topBarViewWithStyle:GLTopBarStyleTitle delegate:self];
    }
    return _topBarView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
