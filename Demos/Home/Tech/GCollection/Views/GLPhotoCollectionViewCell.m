//
//  GLPhotoCollectionViewCell.m
//  Demos
//
//  Created by gaolong on 16/6/22.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLPhotoCollectionViewCell.h"

@implementation GLPhotoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

- (void)commonInit
{
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.bottomLine];
}

- (void)setUpConstraints
{
    
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.text = @"南京----北京，自助游、跟团游";
        _titleLabel.font = APP_FONT_LARGE;
        _titleLabel.textColor = HEXCOLOR(0x999999);
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel newAutoLayoutView];
        _subTitleLabel.text = @"我使用这个东西，不知道会不会产生放大失真，啊呜呜呜";
        _subTitleLabel.textColor = HEXCOLOR(0x666666);
        _subTitleLabel.font = APP_FONT_NORMAL;
    }
    return _subTitleLabel;
}

- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [UIImageView newAutoLayoutView];
        _icon.image = [UIImage imageNamed:@"a"];
        _icon.layer.cornerRadius = 20.0;
    }
    return _icon;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [UIView newAutoLayoutView];
        _bottomLine.backgroundColor = HEXCOLOR(0x999999);
    }
    return _bottomLine;
}

@end
