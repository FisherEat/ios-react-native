//
//  GLWeiboComposeViewController.m
//  Demos
//
//  Created by schiller on 16/6/23.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLWeiboComposeViewController.h"

@interface GLWeiboComposeViewController ()

@property (nonatomic, strong) UIView *toolbar;
@property (nonatomic, strong) UIView *toolbarBackground;

@end

@implementation GLWeiboComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTopBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)setUpTopBar
{
    self.topBarView.topBarStytle = GLTopBarStyleTitleLeftButtonRightButton;
    self.topBarView.titleText = @"发微博";
}

- (void)setUpToolBar
{
    if (_toolbar) {
        return;
    }
    
    _toolbar = [UIView newAutoLayoutView];
    _toolbar.backgroundColor = [UIColor whiteColor];
}

- (UIView *)toolbar
{
    if (!_toolbar) {
        _toolbar = [UIView newAutoLayoutView];
    }
    return _toolbar;
}

- (UIView *)toolbarBackground
{
    if (!_toolbarBackground) {
        _toolbarBackground = [UIView newAutoLayoutView];
    }
    return _toolbarBackground;
}

- (void)topBarLeftButtonPressed:(UIButton *)button
{
    [UIManager backHome];
}

@end
