/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"
#import "RCTRootView.h"
#import "RCTBridge.h"
#import "GLSpringboard.h"
#import "GLNativeTestViewController.h"
#import "GLReactPackageManager.h"
#import "CodePush.h"

@interface AppDelegate () <RCTBridgeDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.backgroundColor = [UIColor whiteColor];
 // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRootView) name:@"ReloadJSDataFromLocal" object:nil];
  [self showRootView];
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)showRootView
{
  _bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
  RCTRootView *rootView = [GLSpringboard rctRootViewWithClassName:@"Home" bridge:_bridge];
  
  GLNativeTestViewController *rootVC = [GLNativeTestViewController new];
  rootVC.view = rootView;
  self.navigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];
  self.window.rootViewController = self.navigationController;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  __block NSURL *jsCodeLocation;
  NSString *serverReactUrl = @"http://120.25.198.16/man.zip";
  [[GLReactPackageManager sharedManager] loadJSPackageWithUrlString:serverReactUrl];
  NSFileManager *fileManager =[NSFileManager defaultManager];
  NSString *localPath = [NSString stringWithFormat:@"%@/reactjs", mDocumentDir];

  if ([fileManager fileExistsAtPath:localPath]) {
    jsCodeLocation = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/main.jsbundle", localPath]];
    return jsCodeLocation;
  }
  
  jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
 // NSString *nameOne = @"main.ios";
 // NSString *nameMinify = @"main";
 // jsCodeLocation = [[NSBundle mainBundle] URLForResource:nameMinify withExtension:@"jsbundle"];
  

  //这里使用codepush提供的url
  return [CodePush bundleURL];
}

+ (AppDelegate *)appDelegate
{
  return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
