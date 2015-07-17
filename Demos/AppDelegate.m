//
//  AppDelegate.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window   = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self showViewControllers];
    [self.window addSubview:self.tabBarController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)showViewControllers
{
    self.rootVC   = [[RootViewController alloc] init];
    self.rootVC.title = @"Demos";
    self.rootVC.hidesBottomBarWhenPushed = NO;
    
    self.secondVC = [[SecondViewController alloc] init];
    self.secondVC.title = @"Second";
    self.secondVC.hidesBottomBarWhenPushed = NO;
    
    self.thirdVC  = [[ThirdViewController alloc] init];
    self.thirdVC.title = @"Third";
    self.thirdVC.hidesBottomBarWhenPushed = NO;
    
    self.forthVC  = [[ForthViewController alloc] init];
    self.forthVC.title = @"Forth";
    self.forthVC.hidesBottomBarWhenPushed = NO;
    
    
    self.rootNaVC   = [[UINavigationController alloc] initWithRootViewController:self.rootVC];
    self.secondNaVC = [[UINavigationController alloc] initWithRootViewController:self.secondVC];
    self.thirdNaVC  = [[UINavigationController alloc] initWithRootViewController:self.thirdVC];
    self.forthNaVC  = [[UINavigationController alloc] initWithRootViewController:self.forthVC];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[self.rootNaVC, self.secondNaVC, self.thirdNaVC, self.forthNaVC];


}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   
}

@end
