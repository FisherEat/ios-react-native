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

//RGB
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kTNTopBarLineRect CGRectMake(0, 64, SCREEN_WIDTH, 0.5)
#define kNavigationBarHeight  64.5

//方法简写
#define mAlert(title, msg, cancel, other)   [[[UIAlertView alloc] initWithTitle:title \
         message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:other, nil] show] 