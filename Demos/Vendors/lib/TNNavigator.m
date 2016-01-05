//
//  TNNavigator.m
//  TuNiuApp
//
//  Created by Ben on 15/6/30.
//  Copyright (c) 2015年 Tuniu. All rights reserved.
//

#import "TNNavigator.h"

@implementation TNNavigator

SINGLETON_IMPLEMENTION(TNNavigator, navigator)

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _map = [[TNNavigationMap alloc] init];
    }
    return self;
}

- (void)to:(NSString *)URLString
{
    [self to:URLString extraParams:nil];
}

- (void)to:(NSString *)URLString extraParams:(NSDictionary *)params
{
    if ([URLString.lowercaseString hasPrefix:@"http://"]
        ||[URLString.lowercaseString hasPrefix:@"https://"])
    {
//        [UIManager showViewControllerWithName:@"TNModernWebViewController" param:@{@"URLString":URLString}];
        return;
    }
    
    NSDictionary *infoDic = [self.map targetViewControllerInfo:URLString];
    UIViewController *viewController = [self.map viewControllerFrom:URLString];
    if (!infoDic || !viewController)
    {
        return;
    }
    
    if ([infoDic[targetControllerParams] count] > 0
        && [viewController respondsToSelector:@selector(parseURLParams:)])
    {
        [viewController performSelector:@selector(parseURLParams:) withObject:infoDic[targetControllerParams]];
    }
    
  //  [UIManager showViewController:viewController param:params];
}

- (void)showViewController:(UIViewController *)viewController param:(NSDictionary *)param
{
    if (!viewController) {
        return;
    }
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)viewController;
       // vc.pa
    }
}
@end
