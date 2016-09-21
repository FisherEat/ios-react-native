//
//  AppDelegate.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "AppDelegate.h"
#import "GLCommonModel.h"
#import "GLJSPatchManager.h"
#import "FLEXManager.h"
#import "GLUIManager.h"
#import "GLNavigationURLHelper.h"
#import "GLReactBaseViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic) UINavigationController *rootNaVC;/**< 首页导航控件 */
@property (strong, nonatomic) UINavigationController *secondNaVC;
@property (strong, nonatomic) UINavigationController *thirdNaVC;
@property (strong, nonatomic) UINavigationController *forthNaVC;
@property (strong, nonatomic) UINavigationController *fifthNaVC;

@property (strong, nonatomic) UITabBarController     *tabBarController;
@property (strong, nonatomic) RootViewController     *rootVC;
@property (strong, nonatomic) SecondViewController   *secondVC;
@property (strong, nonatomic) ThirdViewController    *thirdVC;
@property (strong, nonatomic) ForthViewController    *forthVC;
@property (strong, nonatomic) FifthViewController    *fifthVC;
@property (strong, nonatomic) GLReactBaseViewController *reactVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window   = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    [self getAppConfig];
    [[GLUIManager sharedManager] showRootViewController];
    [self constructUI];
    
    [GLNavigationURLHelper registerAllURLs];
    
    UITableView *table = [UITableView newAutoLayoutView];
    
    
#if Pro
    NSLog(@"1");
#else
    NSLog(@"0");
#endif
    
#ifdef Lite
    
    NSLog(@"Lite");
    
#endif

    
    return YES;
}

/**
 * @brief  引入jspatch热修复。本质上是js文件的下载和js文件的解析并执行
 */
- (void)getAppConfig
{
    NSString *string = @"https://ssl.tuniucdn.com/android/tiyan/jspatch/js014.zip";
    [JSPatchManager loadJSPatchWithZipUrlString:string];
}

#pragma mark -


- (void)constructUI
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button.right = SCREEN_WIDTH - 10.0f;
    button.bottom = SCREEN_HEIGHT - 100;
    
    [button setBackgroundImage:[UIImage imageNamed:@"debug_hammer"] forState:UIControlStateNormal];
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    [button addTarget:self action:@selector(debugButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:button];
}

- (void)debugButtonPressed:(id)sender
{
    [[FLEXManager sharedManager] showExplorer];
}

- (void)getCalendarMsgSuccess:(NSNotification *)aNotification
{
    NSString *dateString = [aNotification object];
    NSLog(@"日期是是是是是 i %@", dateString);

}

#pragma mark method
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

  
}

- (void)applicationWillEnterForeground:(UIApplication *)applicatio
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   
}

@end
