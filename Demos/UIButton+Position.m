//
//  UIButton+Position.m
//  MusicBaseline
//
//  Created by 夏 斌 on 14-3-27.
//  Copyright (c) 2014年 Huawei Technologies Co., Ltd. All rights reserved.
//

#import "UIButton+Position.h"

@implementation UIButton (Position)

- (void)setImageTitleSpace:(CGFloat)space
{
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, space);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, space, 0, 0);
}

- (void)setTitleAlignment:(UIButtonTitleAlignment)titleAlignment
{
    CGPoint newCenter = CGPointZero;
    CGPoint oldCenter = self.titleLabel.center;
    
    switch (titleAlignment)
    {
        case UIButtonTitleAlignmentLeft:
        {
            newCenter = CGPointMake(CGRectGetWidth(self.titleLabel.frame)/2, oldCenter.y);
            break;
        }
        case UIButtonTitleAlignmentCenter:
        {
            newCenter = oldCenter;
            break;
        }
        case UIButtonTitleAlignmentRight:
        {
            newCenter = CGPointMake(CGRectGetWidth(self.frame) - CGRectGetWidth(self.titleLabel.frame)/2, oldCenter.y);
            break;
        }
            
        default:
            break;
    }
    
    CGFloat leftInset = newCenter.x - oldCenter.x;
    CGFloat topInset = newCenter.y - oldCenter.y;
    CGFloat rightInset = - leftInset;
    CGFloat bottomInset = - topInset;
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset)];
}

- (void)setTitleImageVerticalCenter
{
    
}

+ (UIButton*) createButtonWithFrame: (CGRect) frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image ImagePressed:(NSString *)imagePressed
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    UIImage *newImage = [UIImage imageNamed: image];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    UIImage *newPressedImage = [UIImage imageNamed: imagePressed];
    [button setBackgroundImage:newPressedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame Title:(NSString *)title Target:(id)target Selector:(SEL)selector
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame Target:(id)target Image:(NSString *)image ImagePressed:(NSString *)imagePressed
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:frame];
    UIImage *newImage = [UIImage imageNamed:image];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
   // UIImage *newPressedImage = [UIImage imageNamed:imagePressed];
   // [button setBackgroundImage:newPressedImage forState:UIControlStateSelected];

    return button;
}
@end
