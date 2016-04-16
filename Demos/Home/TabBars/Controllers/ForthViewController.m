//
//  ForthViewController.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "ForthViewController.h"
#import "RCTRootView.h"

#define HEAD_AD_VIEW_HEIGHT  (SCREEN_WIDTH/4.0f)
@interface ForthViewController ()

@property (nonatomic, strong) UIView         *adContainer;
@property (nonatomic, strong) NSMutableArray *adViewsArray;
@property (nonatomic, strong) NSArray        *adList;
@property (nonatomic, strong) UIImageView    *adImageView;

@end

@implementation ForthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
    //jsCodeLocation = [NSURL URLWithString:@"http://192.168.1.116:8081/index.ios.bundle?platform=ios&dev=false"];
    //jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"Demos"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    rootView.frame = self.view.bounds;
    
    [self.view addSubview:rootView];
}

- (UIImageView *)supplyAdView:(UIImage *)imgage
{
    self.adContainer.frame = CGRectMake(0, 64.0f - HEAD_AD_VIEW_HEIGHT , self.view.width, HEAD_AD_VIEW_HEIGHT);
    self.adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, HEAD_AD_VIEW_HEIGHT)];
    self.adImageView.image = imgage;
    [self.adContainer addSubview:self.adImageView];
    return self.adImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
