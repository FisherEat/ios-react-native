//
//  config.h
//  gl
//
//  Created by schiller on 15/7/16.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define GLog(fmt, ...) { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#define ULog(...)
#endif

//App Engine
#define HOME_URL_LOG_IN @"http://192.168.31.170/young/network2.php"
#define OFFICE_URL_LOG_IN  @"http://172.30.72.48/userlogin.php"
#define OFFICE_URL_LOG_IN_2 @"http://172.30.74.51/demos/myphps/p2.php"
#define OFFICE_URL_APP_CONFIG @"http:///demos/"

//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)

//获取屏幕高度、宽度
#define SCREEN_WIDTH (IsPortrait ? MIN(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)) : MAX(([UIScreen mainScreen].bounds.size.width) , ([UIScreen mainScreen].bounds.size.height)))

#define SCREEN_HEIGHT (IsPortrait ? MAX(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)) : MIN(([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height)))

#define HEADER_IMAGEVIEW_SHOW_HEIGHT (180 * SCREEN_WIDTH / 320)
//640：360（宽：高）

#define IOS7_OR_LATER [[UIDevice currentDevice].systemVersion floatValue] >= 7.0

//RGB
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kTNTopBarLineRect CGRectMake(0, 64, SCREEN_WIDTH, 0.5)
#define kNavigationBarHeight  64.5

// 常用颜色
#define GL_COLOR_GREEN HEXCOLOR(0x33bd61)
#define COLOR_ORANGE HEXCOLOR(0xff7800)
#define COLOR_RED HEXCOLOR(0xff7c70)
#define COLOR_TEXT_DARK HEXCOLOR(0x333333)
#define COLOR_TEXT_GRAY HEXCOLOR(0x666666)
#define COLOR_TEXT_LIGHT_GRAY HEXCOLOR(0x999999)
#define COLOR_APP_BACKGROUND HEXCOLOR(0xededed)
#define COLOR_SEPARATOR HEXCOLOR(0xc6c6c6)

/************************************* Font ****************************************************/

#define APP_FONT(size) [UIFont systemFontOfSize:size]
#define APP_BOLD_FONT(size) [UIFont boldSystemFontOfSize:size]
#define APP_FONT_SMALL APP_FONT(12.0f)
#define APP_FONT_NORMAL APP_FONT(14.0f)
#define APP_FONT_LARGE APP_FONT(16.0f)


//方法简写
#define mAlert(title, msg, cancel, other)   [[[UIAlertView alloc] initWithTitle:title \
         message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:other, nil] show]

#define kAlert(msg) [[[UIAlertView alloc] initWithTitle:@"提示" \
message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil] show]

#define HEXCOLOR(hexColorValue) [UIColor colorWithHex:hexColorValue]