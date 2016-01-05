//
//  GSOnePixelLine.h
//  GymStore
//
//  Created by Ben on 15/7/11.
//  Copyright (c) 2015年 X-Team. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XTLinePosition)
{
    GSLinePositionTop = 0,
    GSLinePositionLeft = 1,
    GSLinePositionRight = 2,
    GSLinePositionBottom = 3
};

#define SINGLE_LINE_WIDTH (1/[UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET ((1/[UIScreen mainScreen].scale)/2)

IB_DESIGNABLE
@interface XTOnePixelLine : UIView

@property (strong, nonatomic) IBInspectable UIColor *lineColor;
// IBInspectable 不支持枚举类型，所以用Integer代替
@property (assign, nonatomic) IBInspectable NSInteger linePosition;

@end
