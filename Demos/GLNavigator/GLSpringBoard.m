//
//  GLSpringBoard.m
//  Demos
//
//  Created by gaolong on 16/4/18.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLSpringBoard.h"
#import "RCTRootView.h"
#import "RCTBridgeModule.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "AppDelegate.h"

@implementation GLSpringBoard

+ (RCTRootView *)rctRootViewWithClassName:(NSString *)className bridge:(RCTBridge *)bridge
{
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"Demos" initialProperties:@{@"className" :className}];
    rootView.frame = [UIScreen mainScreen].bounds;
    return rootView;
}

@end
