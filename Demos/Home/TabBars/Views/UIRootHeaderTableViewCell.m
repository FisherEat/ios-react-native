//
//  UIRootHeaderTableViewCell.m
//  Demos
//
//  Created by gaolong on 16/2/10.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "UIRootHeaderTableViewCell.h"

@implementation UIRootHeaderTableViewCell

@end

@implementation GLRootHomeButtonViewCell


@end

#pragma mark - GLRootHomeSingleViewCell
@interface GLRootHomeSingleViewCell ()

@property (nonatomic, strong) GLRootSingelCellModel *cellModel;

@end

@implementation GLRootHomeSingleViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell)];
    [self addGestureRecognizer:tapGesture];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.accessoryImg];
    [self.contentView addSubview:self.bottomLine];
    [self setUpConstraints];
}

- (void)setUpConstraints
{
    [self.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:self.contentView.height];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.0f];
    [self.accessoryImg autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.accessoryImg autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.accessoryImg autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.0f];
    [self.accessoryImg autoSetDimension:ALDimensionWidth toSize:50.0f];
    [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:1.0f];
    [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.bottomLine autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.bottomLine autoSetDimension:ALDimensionHeight toSize:2.0f];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.font = APP_FONT_LARGE;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)accessoryImg
{
    if (!_accessoryImg) {
        _accessoryImg = [UIImageView newAutoLayoutView];
        _accessoryImg.image = [UIImage imageNamed:@""];
    }
    return _accessoryImg;
}

- (XTOnePixelLine *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [XTOnePixelLine newAutoLayoutView];
    }
    return _bottomLine;
}

- (void)bindModel:(id)model
{
    self.cellModel = (GLRootSingelCellModel *)model;
    self.titleLabel.text = self.cellModel.titleName;
    self.cellID = self.cellModel.cellId;
}

- (void)tapCell
{
    if ([self.delegate respondsToSelector:@selector(singleCellDidClicked:)]) {
        [self.delegate singleCellDidClicked:self.cellModel];
    }
}

@end