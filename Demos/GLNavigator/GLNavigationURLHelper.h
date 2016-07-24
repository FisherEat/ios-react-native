//
//  GLNavigationURLHelper.h
//  Demos
//
//  Created by gaolong on 16/2/5.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *const GLURLDemoButtonCell;
FOUNDATION_EXTERN NSString *const GLURLDemoScrollCell;
FOUNDATION_EXTERN NSString *const GLURLDemoTabBarCell;
FOUNDATION_EXTERN NSString *const GLURLDemoAnimationCell;
FOUNDATION_EXTERN NSString *const GLURLDemoNetWorkCell;
FOUNDATION_EXTERN NSString *const GLURLDemoAdScrollTimerCell;
FOUNDATION_EXTERN NSString *const GLURLDemoLoginCell;
FOUNDATION_EXTERN NSString *const GLURLDemoTopBarCell;
FOUNDATION_EXTERN NSString *const GLURLDemoWebViewCell;
FOUNDATION_EXTERN NSString *const GLURLDemoTableViewCell;
FOUNDATION_EXPORT NSString *const GLURLDemoThreadViewCell;
FOUNDATION_EXPORT NSString *const GLURLDemoMantleViewCell;
FOUNDATION_EXPORT NSString *const GLURLDemoReactViewCell;
FOUNDATION_EXPORT NSString *const GLURLDemoRuntimeCell;
FOUNDATION_EXPORT NSString *const GLURLDemoScrollListCell;
@interface GLNavigationURLHelper : NSObject

+ (void)registerAllURLs;

@end
