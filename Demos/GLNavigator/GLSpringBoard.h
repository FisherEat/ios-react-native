//
//  GLSpringBoard.h
//  Demos
//
//  Created by gaolong on 16/4/18.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"
@class RCTRootView;
@class RCTBridge;

@interface GLSpringBoard : NSObject<RCTBridgeModule>

+ (RCTRootView *)rctRootViewWithClassName:(NSString *)className bridge:(RCTBridge *)bridge params:(NSDictionary *)params;

@end
