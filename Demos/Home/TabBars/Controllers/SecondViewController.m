//
//  SecondViewController.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "SecondViewController.h"
#import "UIViewController+ScrollingNavbar.h"

@interface SecondViewController ()<UIScrollViewDelegate,AMScrollingNavbarDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSLayoutConstraint *headerLayout;
@property (nonatomic, strong) UIView       *headerView;
@property (nonatomic, strong) UIView       *contentView;
@property (nonatomic, strong) UIToolbar    *topBar;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"ScrollView"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x184fa2)];
    [self fakeContent];
    
     [self followScrollView:self.scrollView withDelay:60];
    [self setScrollableViewConstraint:self.headerLayout withOffset:60];
    
 }

- (void)fakeContent {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -60, self.view.width, self.view.height)];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 40)];
    [label setText:@"My content"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Futura" size:24]];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:label];
    [self.view setBackgroundColor:UIColorFromRGB(0x08245d)];
    [self.scrollView setBackgroundColor:UIColorFromRGB(0x08245d)];
    
    // Fake some content
    [self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 800)];
    [self.view addSubview:self.scrollView];
}


@end