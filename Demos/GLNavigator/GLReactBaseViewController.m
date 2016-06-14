//
//  GLReactBaseViewController.m
//  Demos
//
//  Created by schiller on 16/6/14.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLReactBaseViewController.h"
#import "RCTRootView.h"
#import "GLSpringBoard.h"
#import "Param-local.h"

@interface GLReactBaseViewController () <RCTBridgeDelegate>

@end

@implementation GLReactBaseViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initReactView];
}

- (void)initReactView
{
    _bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
    RCTRootView *rootView = [GLSpringBoard rctRootViewWithClassName:self.className
                                                         moduleName:self.moduleName
                                                             bridge:_bridge
                                                             params:nil];
    rootView.frame = self.view.bounds;
    [self.view addSubview:rootView];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
    return kJSCodeLocationURL;
}

@end
