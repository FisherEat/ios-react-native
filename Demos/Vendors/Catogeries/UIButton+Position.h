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

/**
 * @author Edited by schiller, 15-08-29 14:08:12
 *
 * @brief  自定义UIButton快捷方式
 *
 * @param frame
 * @param target
 * @param selector
 * @param image
 * @param imagePressed
 *
 * @return
 */
+ (UIButton*) createButtonWithFrame: (CGRect) frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image ImagePressed:(NSString *)imagePressed;

+ (UIButton *) createButtonWithFrame:(CGRect)frame Title:(NSString *)title Target:(id)target Selector:(SEL)selector;

+ (UIButton *)createButtonWithFrame:(CGRect)frame Target:(id)target  Image:(NSString *)image ImagePressed:(NSString *)imagePressed;

@end
