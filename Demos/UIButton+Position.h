//
//  UIButton+Position.h
//  MusicBaseline
//
//  Created by 夏 斌 on 14-3-27.
//  Copyright (c) 2014年 Huawei Technologies Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIButtonTitleAlignment)
{
    UIButtonTitleAlignmentLeft = 0,
    UIButtonTitleAlignmentCenter,
    UIButtonTitleAlignmentRight
};

@interface UIButton (Position)

/**
 *  设置Title和Image的距离
 *
 *  @param space 距离
 */
- (void)setImageTitleSpace:(CGFloat)space;

/**
 *  设置Title对齐方式
 *
 *  @param titleAlignment 对齐方式
 */
- (void)setTitleAlignment:(UIButtonTitleAlignment)titleAlignment;

/**
 *  设置iamge title垂直居中
 */
- (void)setTitleImageVerticalCenter;

@end
