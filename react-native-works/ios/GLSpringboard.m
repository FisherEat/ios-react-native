//
//  GLSpringboard.m
//  rnToday_2
//
//  Created by gaolong on 16/3/31.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "GLSpringboard.h"
#import "GLNativeTestViewController.h"
#import "AppDelegate.h"

@implementation GLSpringboard
RCT_EXPORT_MODULE();

+ (RCTRootView *)rctRootViewWithClassName:(NSString *)clssname bridge:(RCTBridge *)bridge
{
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"rnToday_2" initialProperties:@{@"classname": clssname}];
  rootView.frame = [UIScreen mainScreen].bounds;
  return rootView;
}

RCT_EXPORT_METHOD(showNativeView:(NSDictionary*)params callback:(RCTResponseSenderBlock)callback) {
  GLNativeTestViewController *nativeVC = [GLNativeTestViewController new];
  [[AppDelegate appDelegate].navigationController pushViewController:nativeVC animated:NO];
  callback(@[@{@"data": @"backdata"}]);
}


- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

@end
