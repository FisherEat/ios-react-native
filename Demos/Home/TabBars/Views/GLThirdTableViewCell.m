//
//  GLThirdTableViewCell.m
//  Demos
//
//  Created by gaolong on 16/6/22.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLThirdTableViewCell.h"
#import "GLThirdDataSource.h"

@implementation GLThirdTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.bottomLine];
    [self setUpConstraints];
}

- (void)bindModel:(id)model
{
    if (![model isKindOfClass:[GLThirdModel class]]) {
        return;
    }
    GLThirdModel *data = (GLThirdModel *)model;
    self.titleLabel.text = data.title;
    self.subTitleLabel.text = data.subTitle;
}

- (void)setUpConstraints
{
    [self.icon autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 10, 5, 0) excludingEdge:ALEdgeRight];
    [self.icon autoSetDimension:ALDimensionWidth toSize:80.0];
    
    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.icon withOffset:10.0];
    [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.icon];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.0];
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];

    [self.subTitleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.titleLabel];
    [self.subTitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:10.0];
    [self.subTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.0];
    [self.subTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5.0 relation:NSLayoutRelationGreaterThanOrEqual];
    //[self.subTitleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    [self.bottomLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10.0, 0, 10.0) excludingEdge:ALEdgeTop];
    [self.bottomLine autoSetDimension:ALDimensionHeight toSize:0.5];
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.text = @"标题";
        _titleLabel.textColor = HEXCOLOR(0x333333);
        _titleLabel.font = APP_FONT_NORMAL;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel newAutoLayoutView];
        _subTitleLabel.text = @"尊前拟把归期说，欲语春容先惨咽。人生自是有情痴，此恨不关风与月。离歌且莫翻新阕，一曲能教肠寸结。直须看尽洛城花，始共春风容易别。尊前拟把归期说，欲语春容先惨咽。人生自是有情痴，此恨不关风与月。";
        _subTitleLabel.textColor = HEXCOLOR(0x999999);
        _subTitleLabel.font = APP_FONT_SMALL;
        _subTitleLabel.numberOfLines = 0;
    }
    return _subTitleLabel;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [UIView newAutoLayoutView];
        _bottomLine.backgroundColor = HEXCOLOR(0x999999);
    }
    return _bottomLine;
}

- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [UIImageView newAutoLayoutView];
        _icon.image = [UIImage imageNamed:@"a"];
    }
    return _icon;
}

@end
