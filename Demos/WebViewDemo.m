//
//  WebViewDemo.m
//  Demos
//
//  Created by schiller on 15/8/20.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "WebViewDemo.h"

@interface WebViewDemo ()

@property (nonatomic, strong) UIWebView *h5webView;
@property (nonatomic, strong) UIView    *backView;
@property (nonatomic, strong) UIButton  *backBtn;
@property (nonatomic, strong) UIButton  *nativeBtn;
@property (nonatomic, strong) UIButton  *h5Btn;

@end

@implementation WebViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setWebView];
    [self setBackView];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
   self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)setWebView
{
    self.h5webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    [self.h5webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.h5webView];
}

- (void)setBackView
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    self.backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.backView];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (viewController == self) {
//        [navigationController setNavigationBarHidden:YES];
//    }else if ([navigationController isNavigationBarHidden]) {
//        [navigationController setNavigationBarHidden:NO];
//    }
//}

@end
