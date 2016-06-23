//
//  GLWeiboComposeViewController.m
//  Demos
//
//  Created by schiller on 16/6/23.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLWeiboComposeViewController.h"
#import "GLWeiboModel.h"
#import "GLWeiboStatusHelper.h"
#import "GLWeiboStatusXComposeTextParser.h"

#define kToolbarHeight (35 + 46)
@interface GLWeiboComposeViewController ()<YYTextViewDelegate, YYTextKeyboardObserver>

@property (nonatomic, strong) YYTextView *textView;

@property (nonatomic, strong) UIView *toolbar;
@property (nonatomic, strong) UIView *toolbarBackground;
@property (nonatomic, strong) UIButton *toolbarPOIButton;
@property (nonatomic, strong) UIButton *toolbarGroupButton;
@property (nonatomic, strong) UIButton *toolbarPictureButton;
@property (nonatomic, strong) UIButton *toolbarAtButton;
@property (nonatomic, strong) UIButton *toolbarTopicButton;
@property (nonatomic, strong) UIButton *toolbarEmoticonButton;
@property (nonatomic, strong) UIButton *toolbarExtraButton;
@property (nonatomic, assign) BOOL isInputEmoticon;

@end

@implementation GLWeiboComposeViewController

- (instancetype)init {
    self = [super init];
    [[YYTextKeyboardManager defaultManager] addObserver:self];
    return self;
}

- (void)dealloc {
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTopBar];
    [self setUpToolBar];
    [self setUpTextView];
    [_textView becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)setUpTextView {
    if (_textView) return;
    _textView = [YYTextView new];
    if (kSystemVersion < 7) _textView.top = -64;
    _textView.size = CGSizeMake(self.view.width, self.view.height);
    _textView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16);
    _textView.contentInset = UIEdgeInsetsMake(64, 0, kToolbarHeight, 0);
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _textView.extraAccessoryViewHeight = kToolbarHeight;
    _textView.showsVerticalScrollIndicator = NO;
    _textView.alwaysBounceVertical = YES;
    _textView.allowsCopyAttributedString = NO;
    _textView.font = [UIFont systemFontOfSize:17];
    _textView.textParser = [GLWeiboStatusXComposeTextParser new];
    _textView.delegate = self;
    _textView.inputAccessoryView = [UIView new];
    
//    WBTextLinePositionModifier *modifier = [GLWeiboStatusXComposeTextParser new];
//    modifier.font = [UIFont fontWithName:@"Heiti SC" size:17];
//    modifier.paddingTop = 12;
//    modifier.paddingBottom = 12;
//    modifier.lineHeightMultiple = 1.5;
//    _textView.linePositionModifier = modifier;
    
    NSString *placeholderPlainText = nil;
    switch (_type) {
        case WBStatusComposeViewTypeStatus: {
            placeholderPlainText = @"分享新鲜事...";
        } break;
        case WBStatusComposeViewTypeRetweet: {
            placeholderPlainText = @"说说分享心得...";
        } break;
        case WBStatusComposeViewTypeComment: {
            placeholderPlainText = @"写评论...";
        } break;
    }
    if (placeholderPlainText) {
        NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:placeholderPlainText];
        atr.color = UIColorHex(b4b4b4);
        atr.font = [UIFont systemFontOfSize:17];
        _textView.placeholderAttributedText = atr;
    }
    
    [self.view addSubview:_textView];
}

- (void)setUpTopBar
{
    self.topBarView.topBarStytle = GLTopBarStyleTitleLeftButtonRightButton;
    self.topBarView.titleText = @"发微博";
}

- (void)setUpToolBar
{
    if (_toolbar) {
        return;
    }
    
    _toolbar = [UIView new];
    _toolbar.backgroundColor = [UIColor whiteColor];
    _toolbar.size = CGSizeMake(self.view.width, kToolbarHeight);
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    _toolbarBackground = [UIView new];
    _toolbarBackground.backgroundColor = HEXCOLOR(0xf9f9f9);
    _toolbarBackground.size = CGSizeMake(_toolbar.width, 46);
    _toolbarBackground.bottom = _toolbar.height;
    _toolbarBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_toolbar addSubview:_toolbarBackground];
    
    _toolbarBackground.height = 300;
    
    UIView *line = [UIView new];
    line.backgroundColor = HEXCOLOR(0xbfbfbf);
    line.width = _toolbarBackground.width;
    line.height = CGFloatFromPixel(1);
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_toolbarBackground addSubview:line];
    
    _toolbarPOIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _toolbarPOIButton.size = CGSizeMake(88, 26);
    _toolbarPOIButton.centerY = 35/ 2.0;
    _toolbarPOIButton.clipsToBounds = YES;
    _toolbarPOIButton.layer.cornerRadius = _toolbarPOIButton.height / 2;
    _toolbarPOIButton.layer.borderColor = UIColorHex(e4e4e4).CGColor;
    _toolbarPOIButton.layer.borderWidth = CGFloatFromPixel(1);
    _toolbarPOIButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _toolbarPOIButton.adjustsImageWhenHighlighted = NO;
    [_toolbarPOIButton setTitle:@"显示位置 " forState:UIControlStateNormal];
    [_toolbarPOIButton setTitleColor:UIColorHex(939393) forState:UIControlStateNormal];
    [_toolbarPOIButton setImage:[GLWeiboStatusHelper imageNamed:@"compose_locatebutton_ready"] forState:UIControlStateNormal];
    [_toolbarPOIButton setBackgroundImage:[UIImage imageWithColor:UIColorHex(f8f8f8)] forState:UIControlStateNormal];
    [_toolbarPOIButton setBackgroundImage:[UIImage imageWithColor:UIColorHex(e0e0e0)] forState:UIControlStateHighlighted];
    [_toolbar addSubview:_toolbarPOIButton];

    _toolbarPictureButton = [self _toolbarButtonWithImage:@"compose_toolbar_picture"
                                                highlight:@"compose_toolbar_picture_highlighted"];
    _toolbarAtButton = [self _toolbarButtonWithImage:@"compose_mentionbutton_background"
                                           highlight:@"compose_mentionbutton_background_highlighted"];
    _toolbarTopicButton = [self _toolbarButtonWithImage:@"compose_trendbutton_background"
                                              highlight:@"compose_trendbutton_background_highlighted"];
    _toolbarEmoticonButton = [self _toolbarButtonWithImage:@"compose_emoticonbutton_background"
                                                 highlight:@"compose_emoticonbutton_background_highlighted"];
    _toolbarExtraButton = [self _toolbarButtonWithImage:@"message_add_background"
                                              highlight:@"message_add_background_highlighted"];
    
    CGFloat one = _toolbar.width / 5;
    _toolbarPictureButton.centerX = one * 0.5;
    _toolbarAtButton.centerX = one * 1.5;
    _toolbarTopicButton.centerX = one * 2.5;
    _toolbarEmoticonButton.centerX = one * 3.5;
    _toolbarExtraButton.centerX = one * 4.5;
    
    _toolbar.bottom = self.view.height;
    [self.view addSubview:_toolbar];

}

- (UIButton *)_toolbarButtonWithImage:(NSString *)imageName highlight:(NSString *)highlightImageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    button.size = CGSizeMake(46, 46);
    [button setImage:[GLWeiboStatusHelper imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[GLWeiboStatusHelper imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    button.centerY = 46 / 2;
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [button addTarget:self action:@selector(_buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbarBackground addSubview:button];
    return button;
}

- (void)_buttonClicked:(UIButton *)button
{
    
}

#pragma mark @protocol YYTextViewDelegate
- (void)textViewDidChange:(YYTextView *)textView {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark @protocol YYTextKeyboardObserver
- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition {
    CGRect toFrame = [[YYTextKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
    if (transition.animationDuration == 0) {
        _toolbar.bottom = CGRectGetMinY(toFrame);
    } else {
        [UIView animateWithDuration:transition.animationDuration delay:0 options:transition.animationOption | UIViewAnimationOptionBeginFromCurrentState animations:^{
            _toolbar.bottom = CGRectGetMinY(toFrame);
        } completion:NULL];
    }
}

- (UIView *)toolbarBackground
{
    if (!_toolbarBackground) {
        _toolbarBackground = [UIView newAutoLayoutView];
    }
    return _toolbarBackground;
}

- (void)topBarLeftButtonPressed:(UIButton *)button
{
    [UIManager backHome];
}

@end
