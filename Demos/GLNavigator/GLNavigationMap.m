//
//  GLNavigationMap.m
//  Demos
//
//  Created by gaolong on 16/2/5.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLNavigationMap.h"

@interface GLNavigationMap ()

@property (nonatomic, strong) NSMutableDictionary *targetViewConstrollersInfo;
@end

NSString *const targetControllerClass = @"targetControllerClass";
NSString *const targetControllerParams = @"targetControllerParams";

@implementation GLNavigationMap

- (instancetype)init
{
    self = [super init];
    if (self) {
        _targetViewConstrollersInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

//使targetViewConstrollersInfo的schemeAnDomain key赋予info 值
- (void)from:(NSString *)URLString toViewController:(NSString *)className
{
    NSString *schemeAnDomain = [self schemeAnDomain:URLString];
    if (!schemeAnDomain) {
        return;
    }
    Class cls = NSClassFromString(className);
    if (![cls isSubclassOfClass:[UIViewController class]]) {
        return;
    }
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    info[targetControllerClass] = className;
    self.targetViewConstrollersInfo[schemeAnDomain] = info;
}

//获取对应URL的 viewcontroller实例
- (UIViewController *)viewConstrollerFrom:(NSString *)URLString
{
    NSString *schemeAndDomain = [self schemeAnDomain:URLString];
    NSDictionary *dic = self.targetViewConstrollersInfo[schemeAndDomain];
    if (!dic) {
        return nil;
    }
    
    NSString *className = dic[targetControllerClass];
    Class cls = NSClassFromString(className);

    return [[cls alloc] init];
}

- (NSDictionary *)targetViewControllerInfo:(NSString *)URLString
{
    NSString *schemeAnDomain = [self schemeAnDomain:URLString];

    NSDictionary *info = self.targetViewConstrollersInfo[schemeAnDomain];
    if (!info) {
        return nil;
    }
    NSDictionary *params = [self URLParams:URLString];
    Class cls = NSClassFromString(info[targetControllerClass]);
    if (params) {
        NSDictionary *paramKeysMap = nil;
//        if ([cls respondsToSelector:@selector(paramsKeyMap)]) {
//            [paramKeysMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//               
//            }];
//        }
    }
    
    NSMutableDictionary *dic = [info mutableCopy];
    return dic;
}

//获取查询语句前的主机DOMAIN
- (NSString *)schemeAnDomain:(NSString *)URLString
{
    if (URLString.length == 0) {
        return nil;
    }
    NSURL *url = [[NSURL alloc] initWithString:URLString];
    if (!url) {
        return nil;
    }
    NSString *string = URLString;
    if (url.query) {
        string = [URLString stringByReplacingOccurrencesOfString:url.query withString:@""];
        NSLog(@"query = %@", url.query);
        if ([string hasSuffix:@"?"]) {
            return [string substringToIndex:string.length - 1];
        }
    }
    return string.lowercaseString;
}

//获取URL的查询参数, 这种获取方式有问题，健壮性不强。
- (NSDictionary *)URLParams:(NSString *)URLString
{
    NSURL *url = [[NSURL alloc] initWithString:URLString];
    NSString *query = url.query;
    if (!query) {
        return nil;
    }
    
    //将query解码，当query为％乱码时
    query = [query stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSString *paramString in array) {
        NSArray *keyValue = [paramString componentsSeparatedByString:@"="];
        if (keyValue.count < 2) {
            continue;
        }
        params[[keyValue firstObject]] = [keyValue lastObject];
    }
    return params;
}

@end
