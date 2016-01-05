//
//  UIViewController+TNNavigator.h
//  TuNiuApp
//
//  Created by Ben on 15/7/14.
//  Copyright (c) 2015年 Tuniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TNNavigation <NSObject>

@optional

/**
 *  ViewController 类实现，将url中参数的key转成ViewController的property名字
 *  比如ViewController有属性propertyName，而url为@"tuniu://xxx?property_name=123"
 *  实现协议并返回@{@"propertyName":@"property_name"}
 *
 *  @return key值的映射
 */
+ (NSDictionary *)parmsKeyMap;

/**
 *  解析参数
 *  可能ViewController需要的参数是对象，但是通过协议只能传入string类型，需要ViewController转成自己需要的对象
 *
 *  @param params 参数字典
 */
- (void)parseURLParams:(NSDictionary *)params;

/**
 *  如果页面通过storyboard创建，实现该方法，返回storyboard名
 *
 *  @return storyboard名
 */
+ (NSString *)storyboadName;

/**
 *  如果页面通过nib创建，实现该方法，返回storyboard名
 *
 *  @return nib名
 */
+ (NSString *)xibName;

@end
