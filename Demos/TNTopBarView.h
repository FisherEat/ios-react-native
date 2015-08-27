//
//  TNTopBarView.h
//  TuNiuApp
//
//  Created by finder on 13-10-15.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TNTopBarStyle) {
    TNTopBarStyleDefault,
    TNTopBarStyleTitle,
    TNTopBarStyleLeftButton,
    TNTopBarStyleRightButton,
    TNTopBarStyleTitleWithLeftButton,
    TNTopBarStyleTitleWithRightButton,
    TNTopBarStyleTitleWithLeftButtonAndRightButton,
    TNTopBarStyleTitleWithLeftButtonAndRightButtonAndExtendButton,
    TNTopBarStyleTitleWithLeftButtonAndSubTitle,
    TNTopBarStyleTitleWithLeftButtonAndSubTitleAndRightButton,
    TNTopBarStyleTitleWithLeftMenu,
    TNTopBarStyleTitleWithLeftMenuAndRightButton,
    TNTopBarStyleEmpty,
    TNTopBarStyleNone,
};

@protocol TNTopBarViewDelegate;

@interface TNTopBarView : UIView

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *bottomLineView;

@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) NSString *subTitleText;
@property (strong, nonatomic) UILabel *subTitleLabel;

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) UIButton *extendButton;

@property (strong, nonatomic) NSString *leftButtonTitle;
@property (strong, nonatomic) NSString *rightButtonTitle;
@property (strong, nonatomic) NSString *extendButtonTitle;

@property (strong, nonatomic) UIImage *leftButtonImage;
@property (strong, nonatomic) UIImage *rightButtonImage;
@property (strong, nonatomic) UIImage *extendButtonImage;

@property (assign, nonatomic) TNTopBarStyle topBarStyle;

@property (weak, nonatomic) id<TNTopBarViewDelegate> delegate;

@property (nonatomic, strong) UIButton *dockButton;

- (void)addDockButton;

- (id)initWithFrame:(CGRect)frame topBarStyle:(TNTopBarStyle)topBarStyle delegate:(id<TNTopBarViewDelegate>)delegate;

+ (TNTopBarView *)topBarViewWithStyle:(TNTopBarStyle)topBarStyle delegate:(id<TNTopBarViewDelegate>)delegate;

- (void)setRightButtonImage:(UIImage *)rightButtonImage andHighlightedImage:(UIImage *)highlightedImage;

- (void)setExtendButtonImage:(UIImage *)extendButtonImage andHighlightedImage:(UIImage *)highlightedImage;

-(void)setRightButtonFromShareButton:(UIButton *)shareButton;
-(void)setExtendButtonFromShareButton:(UIButton *)shareButton;

@end

@protocol TNTopBarViewDelegate <NSObject>

@optional
- (void)topBarLeftButtonPressed:(UIButton *)button;
- (void)topBarRightButtonPressed:(UIButton *)button;
- (void)topBarExtendButtonPressed:(UIButton *)button;
- (void)topBarDockButtonClicked:(UIButton *)button;
@end
