//
//  GLReactPackageManager.h
//  rnToday_2
//
//  Created by gaolong on 16/4/16.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonDefine.h"
#import "GLRNAppDefines.h"

@interface GLReactPackageManager : NSObject

SINGLETON_INTERFACE(GLReactPackageManager, sharedManager)

- (void)loadJSPackageWithUrlString:(NSString *)urlString;

@end
