//
//  GLUIManager.h
//  Demos
//
//  Created by gaolong on 16/2/6.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

//跳转至根tab bar
typedef NS_ENUM(NSInteger, GLTabBarViewControllerType)
{
    GLTabBarViewControllerTypeRoot = 0,
    GLTabBarViewControllerTypeSecond,
    GLTabBarViewControllerTypeThird,
    GLTabBarViewControllerTypeForth,
    GLTabBarViewControllerTypeFifth
};

//跳转到各页面的方式
typedef NS_ENUM(NSInteger, GLUIManagerShowType)
{
    GLUIManagerShowTypePush = 0,
    GLUIManagerShowTypePresent,
    GLUIManagerShowTypeAddSubview,
};

#define UIManager [GLUIManager sharedManager]

@interface GLUIManager : NSObject

@property (nonatomic, strong) UITabBarController *tabBarController;

SINGLETON_INTERFACE(GLUIManager, sharedManager)

- (void)showRootViewController;
- (void)showTabViewControllerWith:(GLTabBarViewControllerType)type;
- (void)backHome;
//- (UIViewController *)backToControllerWithClass:(Class)viewControllerClass;

- (void)showViewControllerWithName:(NSString *)vcName;
- (void)showViewControllerWithName:(NSString *)vcName params:(id)params;
- (void)showViewControllerWithClass:(Class)class;
- (void)showViewControllerWithClass:(Class)class params:(id)params;
- (void)showViewController:(UIViewController *)viewController;
- (void)showViewController:(UIViewController *)viewController params:(id)params;
- (void)showViewController:(UIViewController *)viewController params:(id)params showType:(GLUIManagerShowType)showType;

@end
