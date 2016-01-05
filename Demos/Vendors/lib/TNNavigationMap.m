//
//  TNNavigationMap.m
//  TuNiuApp
//
//  Created by Ben on 15/6/30.
//  Copyright (c) 2015年 Tuniu. All rights reserved.
//

#import "TNNavigationMap.h"
#import <objc/runtime.h>
#import "TNNavigationProtocol.h"

@interface TNNavigationMap ()

@property (strong, nonatomic) NSMutableDictionary *targetViewControllersInfo;

@end

NSString *const targetControllerClass = @"targetControllerClass";
NSString *const targetControllerNib = @"targetControllerNib";
NSString *const targetControllerStoryboard = @"targetControllerStoryboard";
NSString *const targetControllerParams = @"targetControllerParams";

@implementation TNNavigationMap

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _targetViewControllersInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - Public APIs

- (void)from:(NSString *)URLString toViewController:(NSString *)className
{
    NSString *schemeAnDomain = [self schemeAnDomain:URLString];
    if (!schemeAnDomain)
    {
        return;
    }
    Class cls = NSClassFromString(className);
    if (![cls isSubclassOfClass:[UIViewController class]])
    {
        return;
    };
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    info[targetControllerClass] = className;
    
    if ([cls respondsToSelector:@selector(storyboadName)])
    {
        NSString *storyboardName = [cls storyboadName];
        [info setValue:storyboardName forKey:targetControllerStoryboard];
    }
    
    if ([cls respondsToSelector:@selector(xibName)])
    {
        NSString *xibName = [cls xibName];
        [info setValue:xibName forKey:targetControllerNib];
    }
    
    self.targetViewControllersInfo[schemeAnDomain] = info;
}

- (UIViewController *)viewControllerFrom:(NSString *)URLString
{
    NSString *schemeAnDomain = [self schemeAnDomain:URLString];
    NSDictionary *dic = self.targetViewControllersInfo[schemeAnDomain];
    if (!dic)
    {
        return nil;
    }
    
    NSString *className = dic[targetControllerClass];
    NSString *storyboardName = dic[targetControllerStoryboard];
    if (storyboardName)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        return [storyboard instantiateViewControllerWithIdentifier:className];
    }
    
    Class cls = NSClassFromString(className);
    NSString *nibName = dic[targetControllerNib];
    if (nibName)
    {
        return [[cls alloc] initWithNibName:nibName bundle:nil];
    }
    else
    {
        return [[cls alloc] init];
    }
}

- (NSDictionary *)targetViewControllerInfo:(NSString *)URLString
{
    NSString *schemeAnDomain = [self schemeAnDomain:URLString];
    
    NSDictionary *info = self.targetViewControllersInfo[schemeAnDomain];
    if (!info)
    {
        return nil;
    }
    NSDictionary *params = [self URLParams:URLString];
    NSMutableDictionary *formattedParams = nil;
    Class cls = NSClassFromString(info[targetControllerClass]);
    if (params)
    {
        NSDictionary *paramKeysMap = nil;
        if ([cls respondsToSelector:@selector(parmsKeyMap)])
        {
            paramKeysMap = [cls parmsKeyMap];
        }
        formattedParams = [NSMutableDictionary dictionaryWithDictionary:params];
        
        [paramKeysMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (formattedParams[obj])
            {
                formattedParams[key] = formattedParams[obj];
                [formattedParams removeObjectForKey:obj];
            }
        }];
    }
    
    NSMutableDictionary *dic = [info mutableCopy];
    if (formattedParams)
    {
        dic[targetControllerParams] = formattedParams;
    }
    
    return dic;
}

#pragma mark - Utility

- (NSString *)schemeAnDomain:(NSString *)URLString
{
    if (URLString.length == 0)
    {
        return nil;
    }
    NSURL *url = [[NSURL alloc] initWithString:URLString];
    if (!url)
    {
        return nil;
    }
    
    NSString *string = URLString;
    if (url.query)
    {
        string = [URLString stringByReplacingOccurrencesOfString:url.query withString:@""];
        if ([string hasSuffix:@"?"])
        {
            return [string substringToIndex:string.length - 1];
        }
    }
    return string.lowercaseString;
}

- (NSDictionary *)URLParams:(NSString *)URLString
{
    NSURL *url = [[NSURL alloc] initWithString:URLString];
    NSString *query = url.query;
    if (!query)
    {
        return nil;
    }
    
    query = [query stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSString *paramString in array)
    {
        NSArray *keyValue = [paramString componentsSeparatedByString:@"="];
        if (keyValue.count < 2)
        {
            continue;
        }
        params[[keyValue firstObject]] = [keyValue lastObject];
    }
    return params;
}

@end
