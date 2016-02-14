//
//  GLNavigationMap.h
//  Demos
//
//  Created by gaolong on 16/2/5.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const targetControllerClass;
FOUNDATION_EXPORT NSString *const targetControllerParams;

@interface GLNavigationMap : NSObject

- (void)from:(NSString *)URLString toViewController:(NSString *)className;

- (NSDictionary *)targetViewControllerInfo:(NSString *)URLString;

- (UIViewController *)viewConstrollerFrom:(NSString *)URLString;

//- (NSMutableDictionary *)registeredMapInfo;

@end
