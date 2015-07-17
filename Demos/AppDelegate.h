//
//  AppDelegate.h
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "UITabBarViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "config.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *rootNaVC;
@property (strong, nonatomic) UINavigationController *secondNaVC;
@property (strong, nonatomic) UINavigationController *thirdNaVC;
@property (strong, nonatomic) UINavigationController *forthNaVC;

@property (strong, nonatomic) UITabBarController     *tabBarController;
@property (strong, nonatomic) RootViewController     *rootVC;
@property (strong, nonatomic) SecondViewController   *secondVC;
@property (strong, nonatomic) ThirdViewController    *thirdVC;
@property (strong, nonatomic) ForthViewController    *forthVC;

@end

