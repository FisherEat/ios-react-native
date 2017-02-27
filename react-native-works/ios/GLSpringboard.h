//
//  GLSpringboard.h
//  rnToday_2
//
//  Created by gaolong on 16/3/31.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTRootView.h"
#import "RCTBridgeModule.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@interface GLSpringboard : NSObject <RCTBridgeModule>

+ (RCTRootView *)rctRootViewWithClassName:(NSString *)clssname bridge:(RCTBridge *)bridge;

@end
