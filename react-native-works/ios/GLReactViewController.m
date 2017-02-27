//
//  GLReactViewController.m
//  rnToday_2
//
//  Created by gaolong on 16/4/2.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "GLReactViewController.h"
#import "GLNativeTestViewController.h"
#import "GLSpringboard.h"
#import "AppDelegate.h"

@interface GLReactViewController ()

@property (nonatomic, strong)RCTRootView *rootView;

@end

@implementation GLReactViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  self.navigationController.title = @"Test React";
  self.rootView = [GLSpringboard rctRootViewWithClassName:@"Search" bridge:[AppDelegate appDelegate].bridge];
  [self.view addSubview:self.rootView];
  [self.rootView.bridge.eventDispatcher sendDeviceEventWithName:@"reactjselected" body:@{@"selectedClass": NSStringFromClass([self class])}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
