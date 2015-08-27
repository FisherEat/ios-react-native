//
//  TNTopBarView.m
//  TuNiuApp
//
//  Created by finder on 13-10-15.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import "TNTopBarView.h"

#define kTNTopBarRect CGRectMake(0, 0, SCREEN_WIDTH, 64.5)
#define kTNTopBarLineRect CGRectMake(0, 64, SCREEN_WIDTH, 0.5)
#define kTNTopBarTitleLabelRect CGRectMake((self.frame.size.width - 180) / 2, 20, 180, 44)
#define kTNTopBarWithSubtitleTitleLabelRect CGRectMake((SCREEN_WIDTH - 120)/2, 20, 120, 30)
#define kTNTopBarSubTitleLabelRect CGRectMake((SCREEN_WIDTH - 120)/2, 44, 120, 20)
#define kTNTopBarLeftButtonRect CGRectMake(0, 20, 65, 44)

#define kTNTopBarRightButtonRect CGRectMake(SCREEN_WIDTH - 100, 20, 90, 44)
#define kTNTopBarRightButtonWithExtendRect CGRectMake(SCREEN_WIDTH - 64, 20, 50, 44)
#define kTNTopBarExtendButtonRect CGRectMake(SCREEN_WIDTH - 114, 20, 50, 44)

#define kTNTopBarButtonTitleFont [UIFont systemFontOfSize:17]

@interface TNTopBarView ()

@end

@implementation TNTopBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame topBarStyle:(TNTopBarStyle)topBarStyle delegate:(id<TNTopBarViewDelegate>)delegate
{
    self = [self initWithFrame:frame];
    if (self) {
        [self setTopBarStyle:topBarStyle];
        _delegate = delegate;
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (TNTopBarView *)topBarViewWithStyle:(TNTopBarStyle)topBarStyle delegate:(id<TNTopBarViewDelegate>)delegate
{
    TNTopBarView *topBarView = [[TNTopBarView alloc] initWithFrame:kTNTopBarRect topBarStyle:topBarStyle delegate:delegate];
    
    return topBarView;
}

- (void)setupTopBarView:(TNTopBarStyle)topBarStyle
{
    for (UIView *item in self.subviews) {
        [item removeFromSuperview];
    }
    
    switch (topBarStyle) {
        case TNTopBarStyleDefault:
            [self addSubview:self.backgroundView];
            break;
            
        case TNTopBarStyleTitle:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            break;
            
        case TNTopBarStyleLeftButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.leftButton];
            break;
            
        case TNTopBarStyleRightButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.rightButton];
            break;
            
        case TNTopBarStyleTitleWithLeftButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.leftButton];
            break;
            
        case TNTopBarStyleTitleWithRightButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.rightButton];
            break;
            
        case TNTopBarStyleTitleWithLeftButtonAndRightButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.leftButton];
            [self addSubview:self.rightButton];
            break;
            
        case TNTopBarStyleTitleWithLeftButtonAndRightButtonAndExtendButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.leftButton];
            [self addSubview:self.extendButton];
            [self addSubview:self.rightButton];
            break;
            
        case TNTopBarStyleEmpty:
            break;
            
        case TNTopBarStyleNone:
            self.frame = CGRectZero;
            break;
            
        case TNTopBarStyleTitleWithLeftButtonAndSubTitle:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.subTitleLabel];
            [self addSubview:self.leftButton];
            break;
            
        case TNTopBarStyleTitleWithLeftButtonAndSubTitleAndRightButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.leftButton];
            [self addSubview:self.rightButton];
            [self addSubview:self.subTitleLabel];
            break;
        
        case TNTopBarStyleTitleWithLeftMenu:
            [self addSubview:self.backgroundView]; 
            [self addSubview:self.titleLabel];
            [self addSubview:self.leftButton];
        
            break;
            
        case TNTopBarStyleTitleWithLeftMenuAndRightButton:
            [self addSubview:self.backgroundView];
            [self addSubview:self.titleLabel];
            [self addSubview:self.leftButton];
            [self addSubview:self.rightButton];
    
            break;
            
        default:
            break;
    }
    
    if (self.dockButton != nil)
    {
        [self addSubview:self.dockButton];
    }
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {

        UIView *view = [[UIView alloc] initWithFrame:kTNTopBarRect];
        view.backgroundColor = [UIColor colorwithHexString:@"#f8f8f8"];
        _bottomLineView = [[UIView alloc] initWithFrame:kTNTopBarLineRect];
        _bottomLineView.backgroundColor = [UIColor colorwithHexString:@"#c6c6c6"];
        [view addSubview:_bottomLineView];
//        _backgroundView = view;
        
//        TNBlurView *blurView = [[TNBlurView alloc] initWithFrame:kTNTopBarRect];
//        [blurView setBlurTintColor:[UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:0.0f]];
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) {
//            blurView.alpha = 0.9f;
//        }
//        [blurView addSubview:_bottomLineView];
        
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
//            _backgroundView = blurView;
//        } else {
//            _backgroundView = view;
//        }
        //TNBlurView导致ios7下alpha渐变异常
        _backgroundView = view;
    }
    return _backgroundView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:kTNTopBarTitleLabelRect];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor colorwithHexString:@"#000000"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    
    if ((_topBarStyle == TNTopBarStyleTitleWithLeftButtonAndSubTitle) || (_topBarStyle == TNTopBarStyleTitleWithLeftButtonAndSubTitleAndRightButton)) {
        _titleLabel.frame = kTNTopBarWithSubtitleTitleLabelRect;
    }
    else {
        _titleLabel.frame = kTNTopBarTitleLabelRect;
    }
    
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:kTNTopBarSubTitleLabelRect];
        _subTitleLabel.textAlignment = NSTextAlignmentLeft;
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        _subTitleLabel.textColor = [UIColor colorwithHexString:@"#999999"];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _subTitleLabel;
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _leftButton.titleLabel.font = kTNTopBarButtonTitleFont;

        //Default left menu style.
        if (TNTopBarStyleTitleWithLeftMenu == self.topBarStyle
            || TNTopBarStyleTitleWithLeftMenuAndRightButton == self.topBarStyle) {
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
            
            _leftButton.frame = kTNTopBarLeftButtonRect;
            [_leftButton setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
            //[_leftButton setImageTitleSpace:5.0f];
        }
        
        [_leftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.titleLabel.font = kTNTopBarButtonTitleFont;
        [_rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_rightButton setTitleColor:[UIColor colorwithHexString:@"#515567"] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor colorwithHexString:@"#33bd61"] forState:UIControlStateHighlighted];
        _rightButton.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 4);
        _rightButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 0, 0);
        [_rightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        if (TNTopBarStyleTitleWithLeftButtonAndRightButtonAndExtendButton == self.topBarStyle) {
            _rightButton.frame = kTNTopBarRightButtonWithExtendRect;
        }else{
            _rightButton.frame = kTNTopBarRightButtonRect;
        }
    }
    
    return _rightButton;
}

- (UIButton *)extendButton {
    if (!_extendButton) {
        _extendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _extendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _extendButton.frame = kTNTopBarExtendButtonRect;
        _extendButton.titleLabel.font = kTNTopBarButtonTitleFont;
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
        
    }
    else {
        _leftButtonTitle = leftButtonTitle;
        [_leftButton setTitle:_leftButtonTitle forState:UIControlStateNormal];
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

- (void)setTopBarStyle:(TNTopBarStyle)topBarStyle
{
    if (_topBarStyle == topBarStyle) {
        
    }
    else {
        _topBarStyle = topBarStyle;
        [self setupTopBarView:_topBarStyle];
    }
}

- (void)leftButtonPressed:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(topBarLeftButtonPressed:)]) {
        [self.delegate topBarLeftButtonPressed:button];
    }
}

- (void)rightButtonPressed:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(topBarRightButtonPressed:)]) {
        [self.delegate topBarRightButtonPressed:button];
    }
}

- (void)extendButtonPressed:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(topBarExtendButtonPressed:)]) {
        [self.delegate topBarExtendButtonPressed:button];
    }
}

#pragma mark - TNStartCityDidChangedNotification
- (void)startCityDidChanged:(id)sender
{
    if ([((NSNotification *)sender) userInfo]) {
        NSString *code = [[((NSNotification *)sender) userInfo] objectForKey:@"code"];
        
        if (![code isEqualToString:@"0"]) {
            [self.leftButton setTitle:@"左边" forState:UIControlStateNormal];
        }
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
