//
//  Param-local.h
//  Demos
//
//  Created by schiller on 16/6/14.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Params_local_h
#define Params_local_h

#if DEBUG // 调试模式

   #if TARGET_IPHONE_SIMULATOR //模拟器
      static NSString *const jsCodeLocation = @"http://localhost:8081/index.ios.bundle?platform=ios&dev=true";
   #elif TARGET_OS_IPHONE  //真机
      static NSString *const jsCodeLocation = @"http://192.168.11.108:8081/index.ios.bundle?platform=ios&dev=true";
   #endif

   #define kJSCodeLocationURL [NSURL URLWithString:jsCodeLocation]

#else  // 发布模式
   #define kJSCodeLocationURL [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"]
#endif


#endif
