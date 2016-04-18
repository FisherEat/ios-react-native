//
//  GLSpringBoard.h
//  Demos
//
//  Created by gaolong on 16/4/18.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCTRootView;
@class RCTBridge;
@interface GLSpringBoard : NSObject

+ (RCTRootView *)rctRootViewWithClassName:(NSString *)className bridge:(RCTBridge *)bridge;

@end
