//
//  TNHomeSpecialSaleCell.h
//  gl
//
//  Created by schiller on 15/7/15.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "TNTableViewCell.h"

@interface TNHomeSpecialSaleView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIView      *lineView;
@property (nonatomic, strong) UILabel     *descLabel;
@property (nonatomic, strong) UILabel     *priceLabel;

@end

@interface TNHomeSpecialSaleCell : TNTableViewCell

@property (nonatomic, strong) UIButton  *leftButton;
@property (nonatomic, strong) UIButton  *rightButton;
@property (nonatomic, strong) UIButton  *middleButton;

@property (nonatomic, strong) UIWebView *leftWebView;
@property (nonatomic, strong) UIWebView *middleWebView;
@property (nonatomic, strong) UIWebView *rightWebView;

@property (nonatomic, strong) UIImageView *leftImgView;
@property (nonatomic, strong) UIImageView *middleImgView;
@property (nonatomic, strong) UIImageView *rightImgView;

- (void)bindSpecialInfos:(NSArray *)specialInfoArray withIndex:(NSInteger)leftIndex;

@end
