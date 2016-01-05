//
//  TNNavigator.h
//  TuNiuApp
//
//  Created by Ben on 15/6/30.
//  Copyright (c) 2015年 Tuniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonDefine.h"
#import "TNNavigationMap.h"
#import "TNNavigationURLs.h"
#import "TNNavigationProtocol.h"

@interface TNNavigator : NSObject

@property (strong, nonatomic, readonly) TNNavigationMap *map;

SINGLETON_INTERFACE(TNNavigator, navigator)

/**
 *  跳转至URL对应的页面，可以是一个HTTP/HTTPS协议，也可以是已注册的自定义协议
 *  参数必须是URL编码过的，否则无法跳转
 *
 *  @param URLString URL字符
 */
- (void)to:(NSString *)URLString;

/**
 *  跳转至URL对应的页面，可以是一个HTTP/HTTPS协议，也可以是已注册的自定义协议，可以带自定义的参数。
 *  自定义参数通常用于传输对象，不想在URL里对参数做编码也可以直接把参数放这里
 *
 *  @param URLString URL字符
 *  @param params    参数
 */
- (void)to:(NSString *)URLString extraParams:(NSDictionary *)params;

@end
