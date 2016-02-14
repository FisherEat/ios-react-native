//
//  GLNavigator.m
//  Demos
//
//  Created by gaolong on 16/2/5.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLNavigator.h"
#import "GLUIManager.h"

@implementation GLNavigator

SINGLETON_IMPLEMENTION(GLNavigator, navigator)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _map = [[GLNavigationMap alloc] init];
    }
    return self;
}

- (BOOL)to:(NSString *)URLString
{
    return [self to:URLString extraParams:nil];
}

- (BOOL)to:(NSString *)URLString extraParams:(NSDictionary *)params
{
    if (!URLString) {
        return NO;
    }
    
    if ([URLString.lowercaseString hasPrefix:@"http://"] || [URLString.lowercaseString hasPrefix:@"https://"] || [URLString.lowercaseString hasPrefix:@"file://"]) {
        NSMutableDictionary *allParams = [NSMutableDictionary dictionaryWithDictionary:params];
        allParams[@"URLString"] = URLString;
        // 调H5页面
        return YES;
    }
    NSDictionary *infoDict = [self.map targetViewControllerInfo:URLString];
    UIViewController *viewController = [self.map viewConstrollerFrom:URLString];
    if (!infoDict || !viewController) {
        NSLog(@"Error happened.");
        return NO;
    }
    //实现跳转和数据解析
    if ([infoDict[targetControllerParams] count] > 0 && [viewController respondsToSelector:@selector(parseURLParams:)]) {
        //通过parseURLParams 解析参数
     [viewController performSelector:@selector(parseURLParams:) withObject:infoDict[targetControllerParams]];
    }
    
    [[GLUIManager sharedManager] showViewController:viewController params:params showType:GLUIManagerShowTypePush];
    
    return YES;
}


@end
