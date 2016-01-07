//
//  WebViewDemo.m
//  Demos
//
//  Created by schiller on 15/8/20.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "WebViewDemo.h"

@interface WebViewDemo ()<UIWebViewDelegate>

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
    [self testReturn];
    
    [self testDictionary];
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
     self.h5webView.delegate = self;
    [self.view addSubview:self.h5webView];
    
    NSString *string = [self schemeAnDmain:@"http://m.tuniu.com/event/newCms/index/name/Koreaback?app_topbar_style=2&utm_source=AppToursChannelC&utm_medium=App&utm_campaign=qiangshihuigui&utm_content=AppChannel"];
    
    NSLog(@"the schemeDomain string %@", string);
}

- (void)testReturn
{
    if (self.h5webView) {
        NSLog(@"webview is not nill");
        return;
    }else {
        NSLog(@"h5webView is nil");
    }
    
    NSLog(@"fuck shit god nice");
}

- (void)testDictionary
{
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithObjects:@[@"zhongguo"] forKeys:@[@"1"]];
    
    NSString *key = @"nimei";
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    dict2[key] = dict1;
    NSLog(@"the dict2 = %@ ", dict2);

}

- (NSString *)schemeAnDmain:(NSString *)URLString
{
    if (URLString.length == 0) {
        return nil;
    }
    NSURL *url = [[NSURL alloc] initWithString:URLString];
    if (!url) {
        return nil;
    }
    
    NSString *string = URLString;
    if (url.query) {
        string = [URLString stringByReplacingOccurrencesOfString:url.query withString:@""];
        if ([string hasSuffix:@"?"]) {
            return [string substringToIndex:string.length - 1];
        }
    }
    return string.lowercaseString;
}

- (void)setBackView
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    self.backView.backgroundColor = [UIColor colorWithWhite:0.693 alpha:1.000];
    self.backView.alpha = 0.8;
    self.backView.layer.cornerRadius = 3.0;
    [self.view addSubview:self.backView];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 0, 25, 25);
    self.backBtn.center = self.backView.center;
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];

}

- (void)pushBack
{
    if (self.h5webView.canGoBack) {
        [self.h5webView goBack];
    }else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"url = %@, navigationType = %@", request, @(navigationType));
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (!webView.loading) {
        NSLog(@"Finish loading!");
    }
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
