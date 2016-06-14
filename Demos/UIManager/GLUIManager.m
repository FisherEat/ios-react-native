//
//  GLUIManager.m
//  Demos
//
//  Created by gaolong on 16/2/6.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLUIManager.h"
#import "RootViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "FifthViewController.h"
#import "GLReactBaseViewController.h"

@interface GLUIManager () <UITabBarControllerDelegate>

@end

@implementation GLUIManager

SINGLETON_IMPLEMENTION(GLUIManager, sharedManager)

#pragma mark - init
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - show root viewcontroller
- (void)showRootViewController
{
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpRootViewConstrollers];
    [UIApplication sharedApplication].keyWindow.rootViewController = self.tabBarController;
}

- (void)setUpRootViewConstrollers
{
    RootViewController *rootVC   = [[RootViewController alloc] init];
    rootVC.title = @"Demos";
    rootVC.hidesBottomBarWhenPushed = NO;
    UIImage *image_1 = [UIImage imageNamed:@"1"];
    UIImage *selectImage_1 = [UIImage imageNamed:@"6"];
    rootVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:image_1 selectedImage:selectImage_1];
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.title = @"Second";
    secondVC.hidesBottomBarWhenPushed = NO;
    UIImage *image_2 = [UIImage imageNamed:@"2"];
    UIImage *selectImage_2 = [UIImage imageNamed:@"7"];
    secondVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:image_2 selectedImage:selectImage_2];
    
    
    ThirdViewController *thirdVC  = [[ThirdViewController alloc] init];
    thirdVC.title = @"Third";
    thirdVC.hidesBottomBarWhenPushed = NO;
    UIImage *image_3 = [UIImage imageNamed:@"3"];
    UIImage *selectImage_3 = [UIImage imageNamed:@"8"];
    thirdVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:image_3 selectedImage:selectImage_3];
    
    ForthViewController *forthVC  = [[ForthViewController alloc] init];
    forthVC.title = @"Forth";
    forthVC.hidesBottomBarWhenPushed = NO;
    UIImage *image_4 = [UIImage imageNamed:@"4"];
    UIImage *selectImage_4 = [UIImage imageNamed:@"9"];
    forthVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:image_4 selectedImage:selectImage_4];
    
//    FifthViewController *fifthVC  = [[FifthViewController alloc] init];
//    fifthVC.title = @"分享";
//    fifthVC.hidesBottomBarWhenPushed = NO;
//    UIImage *image_5 = [UIImage imageNamed:@"5"];
//    UIImage *selectImage_5 = [UIImage imageNamed:@"10"];
//    
//    fifthVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分享" image:image_5 selectedImage:selectImage_5];
    
    GLReactBaseViewController *reactVC = [[GLReactBaseViewController alloc] init];
    reactVC = [[GLReactBaseViewController alloc] init];
    reactVC.title = @"RN测试页面";
    reactVC.hidesBottomBarWhenPushed = NO;
    UIImage *image_5 = [UIImage imageNamed:@"5"];
    UIImage *selectImage_5 = [UIImage imageNamed:@"10"];
    reactVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分享" image:image_5 selectedImage:selectImage_5];
    reactVC.moduleName = @"Demos";
    reactVC.className = @"ForthReactView";
    
    self.tabBarController.viewControllers = @[[self navControllerWithRoot:rootVC],
                                              [self navControllerWithRoot:secondVC],
                                              [self navControllerWithRoot:thirdVC],
                                              [self navControllerWithRoot:forthVC],
                                              [self navControllerWithRoot:reactVC]];
    NSArray *imageNames = @[@"1",@"2", @"3", @"4", @"5"];
    NSArray *selectedImageNames = @[@"6", @"7", @"8", @"9", @"10"];
    [self.tabBarController.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        item.image = [UIImage imageNamed:imageNames[idx]];
        item.selectedImage = [UIImage imageNamed:selectedImageNames[idx]];
    }];
    self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    XTOnePixelLine *topLine = [[XTOnePixelLine alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5f)];
    topLine.backgroundColor = HEXCOLOR(0xd4d4d4);
    [self.tabBarController.tabBar addSubview:topLine];
}

- (UINavigationController *)navControllerWithRoot:(UIViewController *)controller
{
    UINavigationController *aNav = [[UINavigationController alloc] initWithRootViewController:controller];
    aNav.navigationBarHidden = YES;
    return aNav;
}

#pragma mark - show viewcontroller
- (void)showViewController:(UIViewController *)viewController
{
    [self showViewController:viewController params:nil];
}

- (void)showViewController:(UIViewController *)viewController params:(id)params
{
    [self showViewController:viewController params:params showType:GLUIManagerShowTypePush];
}

- (void)showViewController:(UIViewController *)viewController params:(id)params showType:(GLUIManagerShowType)showType
{
    if (!viewController) {
        return;
    }
    if ([viewController isKindOfClass:[UIViewController class]]) {
        //UIViewController *glViewController = (UIViewController *)viewController;
    }
    switch (showType) {
        case GLUIManagerShowTypePush:
        {
            [[self currentNavigationController] pushViewController:viewController animated:YES];
        }
            break;
        case GLUIManagerShowTypePresent:
        {
            
        }
            break;
        default:
            break;
    }
}

- (UINavigationController *)currentNavigationController
{
    return (UINavigationController *)[self.tabBarController selectedViewController];
}

#pragma mark - show view controller with class
- (void)showViewControllerWithClass:(Class)class params:(id)params
{
    UIViewController *viewController = [self viewControllerWithClass:class];
    [self showViewController:viewController params:params];
}

- (void)showViewControllerWithClass:(Class)class
{
    [self showViewControllerWithClass:class params:nil];
}

- (UIViewController *)viewControllerWithClass:(Class)cls
{
    UIViewController *viewController = nil;
    if (![cls isSubclassOfClass:[UIViewController class]]) {
        return nil;
    }
    
    viewController = [[cls alloc] init];
    
    return viewController;
}

#pragma mark - show viewcontroller with name
- (void)showViewControllerWithName:(NSString *)vcName
{
    [self showViewControllerWithClass:NSClassFromString(vcName) params:nil];
}

- (void)showViewControllerWithName:(NSString *)vcName params:(id)params
{
    [self showViewControllerWithClass:NSClassFromString(vcName) params:params];
}

#pragma mark - show tab bar viewcontroller
- (void)showTabViewControllerWith:(GLTabBarViewControllerType)type
{
    UINavigationController *nav = [self currentNavigationController];
    self.tabBarController.selectedIndex = type;
    [nav popToRootViewControllerAnimated:YES];
}

- (void)backHome
{
    [self showTabViewControllerWith:GLTabBarViewControllerTypeRoot];
}

@end
