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

@end
