//
//  ForthViewController.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "ForthViewController.h"
#import "RCTRootView.h"
#import "RCTBridge.h"
#import "GLSpringBoard.h"
#import "GLButtonDemoViewController.h"

#define HEAD_AD_VIEW_HEIGHT  (SCREEN_WIDTH/4.0f)
@interface ForthViewController ()<RCTBridgeDelegate>

@property (nonatomic, strong) UIView         *adContainer;
@property (nonatomic, strong) NSMutableArray *adViewsArray;
@property (nonatomic, strong) NSArray        *adList;
@property (nonatomic, strong) UIImageView    *adImageView;
@property (nonatomic, strong) RCTBridge *bridge;

@end

@implementation ForthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self showReactViewInForthViewController];
}

- (void)showReactViewInForthViewController
{
    _bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
    RCTRootView *rootView = [GLSpringBoard rctRootViewWithClassName:@"ForthReactView" bridge:_bridge params:nil];
    rootView.frame = self.view.bounds;
    [self.view addSubview:rootView];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
    //jsCodeLocation = [NSURL URLWithString:@"http://192.168.1.116:8081/index.ios.bundle?platform=ios&dev=false"];
    //jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
    return jsCodeLocation;
}

+ (void)push
{
    [[GLUIManager sharedManager] showViewControllerWithName:@"GLButtonDemoViewController" params:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
