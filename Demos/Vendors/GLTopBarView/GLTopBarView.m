//
//  GLTopBarView.m
//  Demos
//
//  Created by schiller on 15/8/13.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "GLTopBarView.h"
#import "config.h"
#import "UIButton+Position.h"

#define kGLTopBarRect CGRectMake(0, 0, SCREEN_WIDTH, 64.5)
#define kGLTopBarLineRect CGRectMake(0, 64, SCREEN_WIDTH, 0.5)
#define kGLTopBarTitleLabelRect CGRectMake((self.frame.size.width - 180 ) / 2, 20, 180, 44)
#define kGLTopBarWithSubtitleTitleLabelRect CGRectMake((SCREEN_WIDTH - 120)/2, 20, 120, 30)
#define kGLTopBarSubTitleLabelRect CGRectMake((SCREEN_WIDTH - 120)/2, 44, 120, 20)
#define kGLTopBarLeftButtonRect CGRectMake(0, 20, 65, 44)

#define kGLTopBarRightButtonRect CGRectMake(SCREEN_WIDTH - 100, 20, 90, 44)
#define kGLTopBarRightButtonWithExtendRect CGRectMake(SCREEN_WIDTH - 64, 20, 50, 44)
#define kGLTopBarExtendButtonRect CGRectMake(SCREEN_WIDTH - 114, 20, 50, 44)

#define kGLTopBarButtonTitleFont [UIFont systemFontOfSize:17]

@implementation GLTopBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;

}

- (id)initWithFrame:(CGRect)frame topBarStyle:(GLTopBarStyle)topBarStyle delegate:(id<GLTopBarViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTopBarStytle:topBarStyle];
        _delegate = delegate;
    }
    
    return self;
}

+ (GLTopBarView *)topBarViewWithStyle:(GLTopBarStyle)topBarStyle delegate:(id<GLTopBarViewDelegate>)delegate
{
    GLTopBarView *topBarView = [[GLTopBarView alloc] initWithFrame:kGLTopBarRect topBarStyle:topBarStyle delegate:delegate];
    
    return topBarView;
    
}

- (void)setupTopBarView:(GLTopBarStyle)topBarStyle
{
    for (UIView *item in self.subviews) {
        [item removeFromSuperview];
    }
    
    switch (topBarStyle) {
        case GLTopBarStyleDefault:
            [self addSubview:self.backgroundView];
            break;
            
        case GLTopBarStyleTitle:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            break;
        
        case GLTopBarStyleLeftButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.leftButton];
            break;
        
        case GLTopBarStyleRightButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.rightButton];
            break;
        
        case GLTopBarStyleTitleLeftButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.leftButton];
            break;
            
        case GLTopBarStyleTitleRightButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.rightButton];
            break;
            
        case GLTopBarStyleTitleLeftButtonRightButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.leftButton];
            [self addSubview:self.rightButton];
            break;
            
        case GLTopBarStyleTitleLeftButtonRightButtonExtendButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.leftButton];
            [self addSubview:self.rightButton];
            [self addSubview:self.extendButton];
            break;
            
        case GLTopBarStyleEmpty:
            break;
            
        case GLTopBarStyleNone:
            self.frame = CGRectZero;
            break;
            
        case GLTopBarStyleTitleLeftButtonSubTitle:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.subTitleLabel];
            [self addSubview:self.leftButton];
            break;
        
        case GLTopBarStyleTitleLeftButtonSubTitleRightButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.leftButton];
            [self addSubview:self.subTitleLabel];
            [self addSubview:self.rightButton];
            break;
        
        case GLTopBarStyleTitleLeftMenu:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.leftButton];
            break;
        
        case GLTopBarStyleTitleLeftMenuRightButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.leftButton];
            [self addSubview:self.rightButton];
            break;
        
        default:
            break;
    }
    
    if (self.dockButton) {
        [self addSubview:self.dockButton];
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:kGLTopBarTitleLabelRect];
        _titleLabel.font = [UIFont systemFontOfSize:17.f];
        _titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    
    if ((_topBarStytle == GLTopBarStyleTitleLeftButtonSubTitle) || (_topBarStytle == GLTopBarStyleTitleLeftButtonSubTitleRightButton)) {
        _titleLabel.frame = kGLTopBarWithSubtitleTitleLabelRect;
    }
    else {
        _titleLabel.frame = kGLTopBarTitleLabelRect;
    }
    
    return _titleLabel;
    
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:kGLTopBarSubTitleLabelRect];
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        _subTitleLabel.font = [UIFont systemFontOfSize:12.0f];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _subTitleLabel;
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.titleLabel.font = kGLTopBarButtonTitleFont;
        
        //Default left menu style.
        if (GLTopBarStyleTitleLeftMenu == self.topBarStytle
            || GLTopBarStyleTitleLeftMenuRightButton == self.topBarStytle) {
            [_leftButton setTitleColor:[UIColor colorwithHexString:@"#515567"] forState:UIControlStateNormal];
            [_leftButton setTitleColor:[UIColor colorwithHexString:@"#505264"] forState:UIControlStateHighlighted];
            
            _leftButton.frame = CGRectMake(0.0f, 20.0f, 100.0f, 44.0f);
            
            [_leftButton setImage:[UIImage imageNamed:@"icon_left_deck"] forState:UIControlStateNormal];
            
            [self.leftButton setTitle:@"左边" forState:UIControlStateNormal];
            //根据title大小，设置字体
            NSInteger labelSize = [self.leftButton.titleLabel.text length];
            if (labelSize <= 3) {
                self.leftButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
            }
            else
            {
                self.leftButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            }
            
            _leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            _leftButton.titleEdgeInsets = UIEdgeInsetsMake(1, 1, -1, -6);
            [self.leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        }
        else {
            [_leftButton setTitleColor:HEXCOLOR(0x515567) forState:UIControlStateNormal];
            [_leftButton setTitleColor:HEXCOLOR(0x505264) forState:UIControlStateHighlighted];
            _leftButton.frame = kGLTopBarLeftButtonRect;
            [_leftButton setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
            [_leftButton setImageTitleSpace:5.0f];
        }
        
        [_leftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftButton;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        
        UIView *view = [[UIView alloc] initWithFrame:kGLTopBarRect];
        view.backgroundColor = [UIColor colorwithHexString:@"#f8f8f8"];
        _bottomLineView = [[UIView alloc] initWithFrame:kGLTopBarLineRect];
        _bottomLineView.backgroundColor = [UIColor colorwithHexString:@"#c6c6c6"];
        [view addSubview:_bottomLineView];
        
        _backgroundView = view;
    }
    
    return _backgroundView;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.titleLabel.font = kGLTopBarButtonTitleFont;
        [_rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_rightButton setTitleColor:[UIColor colorwithHexString:@"#515567"] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor colorwithHexString:@"#33bd61"] forState:UIControlStateHighlighted];
        _rightButton.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 4);
        _rightButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 0, 0);
        [_rightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        if (GLTopBarStyleTitleLeftButtonRightButtonExtendButton == self.topBarStytle) {
            _rightButton.frame = kGLTopBarRightButtonWithExtendRect;
        }else{
            _rightButton.frame = kGLTopBarRightButtonRect;
        }
    }
    
    return _rightButton;
}

- (UIButton *)extendButton {
    if (!_extendButton) {
        _extendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _extendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _extendButton.frame = kGLTopBarExtendButtonRect;
        _extendButton.titleLabel.font = kGLTopBarButtonTitleFont;
        [_extendButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_extendButton setTitleColor:[UIColor colorwithHexString:@"#515567"] forState:UIControlStateNormal];
        [_extendButton setTitleColor:[UIColor colorwithHexString:@"#33bd61"] forState:UIControlStateHighlighted];
        _extendButton.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
        _extendButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 0, 0);
        [_extendButton addTarget:self action:@selector(extendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _extendButton;
}

-(void)setRightButtonFromShareButton:(UIButton *)shareButton
{
    _rightButton=shareButton;
    _rightButton.frame=shareButton.frame;
    [_rightButton setImage:[UIImage imageNamed:@"normal_share"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"highlight_share"] forState:UIControlStateHighlighted];
    [_rightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightButton];
}

-(void)setExtendButtonFromShareButton:(UIButton *)shareButton
{
    _extendButton=shareButton;
    _extendButton.frame=shareButton.frame;
    [_extendButton setImage:[UIImage imageNamed:@"normal_share"] forState:UIControlStateNormal];
    [_extendButton setImage:[UIImage imageNamed:@"highlight_share"] forState:UIControlStateHighlighted];
    [_extendButton addTarget:self action:@selector(extendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_extendButton];
}


- (void)setTitleText:(NSString *)titleText
{
    if ([_titleText isEqualToString:titleText]) {
        
    }
    else {
        _titleText = titleText;
        _titleLabel.text = _titleText;
    }
}

- (void)setSubTitleText:(NSString *)subTitleText
{
    if ([_subTitleText isEqualToString:subTitleText]) {
        
    }
    else {
        _subTitleText = subTitleText;
        _subTitleLabel.text = _subTitleText;
    }
}

- (void)setLeftButtonTitle:(NSString *)leftButtonTitle
{
    if ([_leftButtonTitle isEqualToString:leftButtonTitle]) {
        
    }else {
        _leftButtonTitle = leftButtonTitle;
        [_leftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
    }
}

- (void)setRightButtonTitle:(NSString *)rightButtonTitle
{
    if ([_rightButtonTitle isEqualToString:rightButtonTitle]) {
        
    }
    else {
        _rightButtonTitle = rightButtonTitle;
        [_rightButton setTitle:_rightButtonTitle forState:UIControlStateNormal];
    }
}

- (void)setLeftButtonImage:(UIImage *)leftButtonImage
{
    _leftButtonImage = leftButtonImage;
    [_leftButton setImage:_leftButtonImage forState:UIControlStateNormal];
}

- (void)setRightButtonImage:(UIImage *)rightButtonImage
{
    _rightButtonImage = rightButtonImage;
    [_rightButton setImage:_rightButtonImage forState:UIControlStateNormal];
}

- (void)setRightButtonImage:(UIImage *)rightButtonImage andHighlightedImage:(UIImage *)highlightedImage{
    self.rightButtonImage = rightButtonImage;
    [self.rightButton setImage:highlightedImage forState:UIControlStateHighlighted];
}

- (void)setExtendButtonImage:(UIImage *)extendButtonImage andHighlightedImage:(UIImage *)highlightedImage{
    self.extendButtonImage = extendButtonImage;
    [self.extendButton setImage:highlightedImage forState:UIControlStateHighlighted];
}

- (void)setExtendButtonImage:(UIImage *)extendButtonImage
{
    _extendButtonImage = extendButtonImage;
    [_extendButton setImage:_extendButtonImage forState:UIControlStateNormal];
}

- (void)setExtendButtonTitle:(NSString *)extendButtonTitle
{
    if ([_extendButtonTitle isEqualToString:extendButtonTitle]) {
        return;
    }
    
    _extendButtonTitle = extendButtonTitle;
    [_extendButton setTitle:_extendButtonTitle forState:UIControlStateNormal];
}

/**
 bug ：重写setTopBarStytle方法出错，导致该属性无法初始化。
 */

- (void)setTopBarStytle:(GLTopBarStyle)topBarStytle
{
    if (_topBarStytle == topBarStytle) {
        
    }else {
        _topBarStytle = topBarStytle;
        [self setupTopBarView:_topBarStytle];
    }
}

- (void)rightButtonPressed:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(topBarRightButtonPressed:)]) {
        [self.delegate topBarRightButtonPressed:button];
    }
}

- (void)leftButtonPressed:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(topBarLeftButtonPressed:)]) {
        [self.delegate topBarLeftButtonPressed:button];
    }
}

- (void)extendButtonPressed:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(topBarExtendButtonPressed:)]) {
        [self.delegate topBarExtendButtonPressed:button];
    }
}

#pragma mark - Dock

- (void)addDockButton
{
    if (self.dockButton != nil)
    {
        return;
    }
    
    self.dockButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 44.0f, 20, 44, 44)];
    
    [self.dockButton setImage:[UIImage imageNamed:@"icon_nav_dock_entry_close"]
                     forState:UIControlStateNormal];
    [self.dockButton setImage:[UIImage imageNamed:@"icon_nav_dock_entry_open"]
                     forState:UIControlStateSelected];
    [self.dockButton addTarget:self
                        action:@selector(dockButtonClicked:)
              forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.dockButton];
    
}

- (void)dockButtonClicked:(UIButton *)button
{
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(topBarDockButtonClicked:)])
    {
        [self.delegate topBarDockButtonClicked:button];
    }
}

@end
