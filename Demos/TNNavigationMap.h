//
//  TNNavigationMap.h
//  TuNiuApp
//
//  Created by Ben on 15/6/30.
//  Copyright (c) 2015年 Tuniu. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const targetControllerClass;
FOUNDATION_EXPORT NSString *const targetControllerNib;
FOUNDATION_EXPORT NSString *const targetControllerStoryboard;
FOUNDATION_EXPORT NSString *const targetControllerParams;

@interface TNNavigationMap : NSObject

- (void)from:(NSString *)URLString toViewController:(NSString *)className;

- (NSDictionary *)targetViewControllerInfo:(NSString *)URLString;

- (UIViewController *)viewControllerFrom:(NSString *)URLString;

@end
