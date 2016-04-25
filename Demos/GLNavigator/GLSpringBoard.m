//
//  GLSpringBoard.m
//  Demos
//
//  Created by gaolong on 16/4/18.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLSpringBoard.h"
#import "RCTRootView.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "AppDelegate.h"
#import "GLButtonDemoViewController.h"
#import "ForthViewController.h"

@implementation GLSpringBoard
RCT_EXPORT_MODULE();

+ (RCTRootView *)rctRootViewWithClassName:(NSString *)className bridge:(RCTBridge *)bridge params:(NSDictionary *)params
{
    if (!params) {
        params = [NSDictionary dictionary];
    }
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"Demos" initialProperties:@{@"className" :className, @"params": params}];
    rootView.frame = [UIScreen mainScreen].bounds;
    return rootView;
}

RCT_EXPORT_METHOD(showNativeView:(NSDictionary*)params callback:(RCTResponseSenderBlock)callback) {
    //[[GLUIManager sharedManager] showViewControllerWithName:NSStringFromClass([GLButtonDemoViewController class]) params:@{@"className": @""}];
    [ForthViewController push];
}

RCT_EXPORT_METHOD(query:(NSString *)queryData successCallback:(RCTResponseSenderBlock)responseSender)
{
    NSString *ret = @"ret";
    responseSender(@[ret]);
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

@end
