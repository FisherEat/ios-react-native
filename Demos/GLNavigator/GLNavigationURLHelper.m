//
//  GLNavigationURLHelper.m
//  Demos
//
//  Created by gaolong on 16/2/5.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLNavigationURLHelper.h"
#import "GLNavigator.h"
NSString *const GLURLScheme = @"demoapp";
NSString *const GLURLDemoHome = @"demoapp://demo/home";
NSString *const GLURLDemoSecond = @"demoapp://demo/second";
NSString *const GLURLDemoThird = @"demoapp://demo/third";
NSString *const GLURLDemoForth = @"demoapp://demo/forth";
NSString *const GLURLDemoFifth = @"demoapp://demo/fifth";
NSString *const GLURLDemoButtonCell = @"demoapp://demo/home/buttoncell";
NSString *const GLURLDemoScrollCell = @"demoapp://demo/home/scrollcell";
NSString *const GLURLDemoTabBarCell = @"demoapp://demo/home/tabbarcell";
NSString *const GLURLDemoAnimationCell = @"demoapp://demo/home/animationcell";
NSString *const GLURLDemoNetWorkCell = @"demoapp://demo/home/networkcell";
NSString *const GLURLDemoAdScrollTimerCell = @"demoapp://demo/home/adscrolltimercell";
NSString *const GLURLDemoLoginCell = @"demoapp://demo/home/logincell";
NSString *const GLURLDemoTopBarCell = @"demoapp://demo/home/presentcell";
NSString *const GLURLDemoWebViewCell = @"demoapp://demo/home/webviewcell";
NSString *const GLURLDemoTableViewCell = @"demoapp://demo/home/tableviewcell";
NSString *const GLURLDemoThreadViewCell = @"demoapp://demo/home/threadviewcell";
NSString *const GLURLDemoMantleViewCell = @"demoapp://demo/home/mantleviewcell";
NSString *const GLURLDemoReactViewCell = @"demoapp://demo/home/reactviewcell";
NSString *const GLURLDemoRuntimeCell = @"demoapp://demo/home/runtimecell";

@implementation GLNavigationURLHelper

+ (void)registerAllURLs
{
    static NSDictionary *URLClassMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        URLClassMap = @{GLURLDemoHome :@"RootViewController",
                        GLURLDemoSecond :@"SecondViewController",
                        GLURLDemoThird :@"ThirdViewController",
                        GLURLDemoForth :@"ForthViewController",
                        GLURLDemoFifth :@"FifthViewController",
                        GLURLDemoButtonCell :@"GLButtonDemoViewController",
                        GLURLDemoScrollCell :@"ScrollDemoVC",
                        GLURLDemoTabBarCell :@"TarBarDemoVC",
                        GLURLDemoAnimationCell :@"AnimationDemoVC",
                        GLURLDemoNetWorkCell :@"GLNetWorkDemo",
                        GLURLDemoAdScrollTimerCell :@"AdScrollTimerViewController",
                        GLURLDemoLoginCell :@"LoginDemoVC",
                        GLURLDemoTopBarCell :@"GLPresentViewController",
                        GLURLDemoWebViewCell :@"WebViewDemo",
                        GLURLDemoTableViewCell :@"GLUserLoginViewController",
                        GLURLDemoThreadViewCell :@"GLThreadViewController",
                        GLURLDemoMantleViewCell :@"GLMantleViewController",
                        GLURLDemoReactViewCell: @"GLReactBaseViewController",
                        GLURLDemoRuntimeCell: @"GLRuntimeViewController"
                        };
    });
    
    [URLClassMap enumerateKeysAndObjectsUsingBlock:^(NSString *urlString, NSString *  _Nonnull className, BOOL * _Nonnull stop) {
        [[GLNavigator navigator].map from:urlString toViewController:className];
    }];
}

@end
