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

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window   = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self showViewControllers];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    [self getAppConfig];
    
    return YES;
}

/**
 * @brief  引入jspatch热修复。本质上是js文件的下载和js文件的解析并执行
 */
- (void)getAppConfig
{
    NSString *string = @"https://ssl.tuniucdn.com/android/tiyan/jspatch/js014.zip";
    [JSPatchManager loadJSPatchWithZipUrlString:string];
//    [GLCommonModel getAppConfigInfoBlock:^(NSMutableDictionary *infoDict, NSError *error) {
//        NSString *string = @"https://ssl.tuniucdn.com/android/tiyan/jspatch/js014.zip";
//        [JSPatchManager loadJSPatchWithZipUrlString:string];
//    }];
}

#pragma mark -
- (void)showViewControllers
{

    self.rootVC   = [[RootViewController alloc] init];
    self.rootVC.title = @"Demos";
    self.rootVC.hidesBottomBarWhenPushed = NO;
    UIImage *image_1 = [UIImage imageNamed:@"1"];
    UIImage *selectImage_1 = [UIImage imageNamed:@"6"];
    self.rootVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:image_1 selectedImage:selectImage_1];

    self.secondVC = [[SecondViewController alloc] init];
    self.secondVC.title = @"Second";
    self.secondVC.hidesBottomBarWhenPushed = NO;
    UIImage *image_2 = [UIImage imageNamed:@"2"];
    UIImage *selectImage_2 = [UIImage imageNamed:@"7"];
    self.secondVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:image_2 selectedImage:selectImage_2];

    
    self.thirdVC  = [[ThirdViewController alloc] init];
    self.thirdVC.title = @"Third";
    self.thirdVC.hidesBottomBarWhenPushed = NO;
    UIImage *image_3 = [UIImage imageNamed:@"3"];
    UIImage *selectImage_3 = [UIImage imageNamed:@"8"];
    self.thirdVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:image_3 selectedImage:selectImage_3];
    
    self.forthVC  = [[ForthViewController alloc] init];
    self.forthVC.title = @"Forth";
    self.forthVC.hidesBottomBarWhenPushed = NO;
    UIImage *image_4 = [UIImage imageNamed:@"4"];
    UIImage *selectImage_4 = [UIImage imageNamed:@"9"];
    self.forthVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:image_4 selectedImage:selectImage_4];
    
    self.fifthVC  = [[FifthViewController alloc] init];
    self.fifthVC.title = @"分享";
    self.fifthVC.hidesBottomBarWhenPushed = NO;
    UIImage *image_5 = [UIImage imageNamed:@"5"];
    UIImage *selectImage_5 = [UIImage imageNamed:@"10"];
    
    self.fifthVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分享" image:image_5 selectedImage:selectImage_5];
    
    self.rootNaVC   = [[UINavigationController alloc] initWithRootViewController:self.rootVC];
    self.secondNaVC = [[UINavigationController alloc] initWithRootViewController:self.secondVC];
    self.thirdNaVC  = [[UINavigationController alloc] initWithRootViewController:self.thirdVC];
    self.forthNaVC  = [[UINavigationController alloc] initWithRootViewController:self.forthVC];
    self.fifthNaVC  = [[UINavigationController alloc] initWithRootViewController:self.fifthVC];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[self.rootNaVC, self.secondNaVC, self.thirdNaVC, self.forthNaVC, self.fifthNaVC];
    
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCalendarMsgSuccess:) name:@"SelectCalendarFromView" object:nil];
}

- (void)getCalendarMsgSuccess:(NSNotification *)aNotification
{
    NSString *dateString = [aNotification object];
    NSLog(@"日期是是是是是 i %@", dateString);

}

#pragma mark - 
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
