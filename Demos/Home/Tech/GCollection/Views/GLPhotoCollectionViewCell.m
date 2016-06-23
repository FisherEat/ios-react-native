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
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.bottomLine];
    [self setUpConstraints];
}

- (void)setUpConstraints
{
    [self.dateLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0];
    [self.dateLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.bottomLine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.dateLabel];
    [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0];
    [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0];
    [self.bottomLine autoSetDimension:ALDimensionHeight toSize:0.5];
    [self.icon autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.bottomLine withOffset:10.0];
    [self.icon autoSetDimensionsToSize:CGSizeMake(40, 40)];
    [self.icon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0];
    [self.icon autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.bottomLine withOffset:10.0];
    [self.titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.icon];
    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.icon withOffset:10.0];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0 relation:NSLayoutRelationGreaterThanOrEqual];
    
    [self.subTitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:5.0];
    [self.subTitleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.titleLabel];
    [self.subTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0 relation:NSLayoutRelationGreaterThanOrEqual];
}

- (void)bindModel:(id)model
{
    
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel newAutoLayoutView];
        _dateLabel.text = @"2016年6月23日";
        _dateLabel.textColor = HEXCOLOR(0x333333);
        _dateLabel.font = APP_FONT_NORMAL;
    }
    return _dateLabel;
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
        _subTitleLabel.numberOfLines = 2;
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
