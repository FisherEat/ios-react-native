//
//  config.h
//  gl
//
//  Created by schiller on 15/7/16.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)

//获取屏幕高度、宽度
#define SCREEN_WIDTH (IsPortrait ? MIN(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)) : MAX(([UIScreen mainScreen].bounds.size.width) , ([UIScreen mainScreen].bounds.size.height)))

#define SCREEN_HEIGHT (IsPortrait ? MAX(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)) : MIN(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)))

#define HEADER_IMAGEVIEW_SHOW_HEIGHT (180 * SCREEN_WIDTH / 320)//640：360（宽：高）

#define IOS7_OR_LATER [[UIDevice currentDevice].systemVersion floatValue] >= 7.0