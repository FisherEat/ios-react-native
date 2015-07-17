//
//  AnimationDemoVC.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "AnimationDemoVC.h"
#import "UIView+Positioning.h"
#import <pop/POP.h>

@interface AnimationDemoVC ()

@property (nonatomic ,strong) UIButton *myButton;

@end

@implementation AnimationDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self popButton];
}

- (void)popButton
{
    self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myButton.frame   = CGRectMake(0, 0, 100, 100);
    self.myButton.center = self.view.center;
    
    [self.myButton setTitle:@"点击" forState:UIControlStateNormal];
    [self.myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.myButton.layer.backgroundColor = [UIColor colorWithRed:0.379 green:0.799 blue:0.444 alpha:1.000].CGColor;
    [self.myButton addTarget:self action:@selector(showRotationAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myButton];
    
}

- (void)showRotationAnimation:(UIGestureRecognizer *)gesture
{
    switch (gesture) {
        case <#constant#>:
            <#statements#>
            break;
            
        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
