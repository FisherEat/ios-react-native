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
#import "Param-local.h"
#import "GLButtonDemoViewController.h"

@interface ForthViewController ()<RCTBridgeDelegate>

@property (nonatomic, strong) RCTBridge *bridge;
@property (nonatomic, copy) NSString *moduleName;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *params;

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
    RCTRootView *rootView = [GLSpringBoard rctRootViewWithClassName:@"ForthReactView"
                                                         moduleName:@"Demos"
                                                             bridge:_bridge
                                                             params:nil];
    rootView.frame = self.view.bounds;
    [self.view addSubview:rootView];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
    return kJSCodeLocationURL;
}

+ (void)push
{
    [[GLUIManager sharedManager] showViewControllerWithName:@"GLButtonDemoViewController" params:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
