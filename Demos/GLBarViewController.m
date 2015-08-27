//
//  GLBarViewController.m
//  Demos
//
//  Created by schiller on 15/8/27.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "GLBarViewController.h"

@interface GLBarViewController ()
@end

@implementation GLBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
