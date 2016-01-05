//
//  GLTopBarView.h
//  Demos
//
//  Created by schiller on 15/8/13.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GLTopBarStyle)
{
    GLTopBarStyleDefault,
    GLTopBarStyleTitle,
    GLTopBarStyleLeftButton,
    GLTopBarStyleRightButton,
    GLTopBarStyleTitleLeftButton,
    GLTopBarStyleTitleRightButton,
    GLTopBarStyleTitleLeftButtonRightButton,
    GLTopBarStyleTitleLeftButtonRightButtonExtendButton,
    GLTopBarStyleTitleLeftButtonSubTitle,
    GLTopBarStyleTitleLeftButtonSubTitleRightButton,
    GLTopBarStyleTitleLeftMenu,
    GLTopBarStyleTitleLeftMenuRightButton,
    GLTopBarStyleEmpty,
    GLTopBarStyleNone
};

@protocol GLTopBarViewDelegate;

@protocol GLTopBarViewDelegate <NSObject>

@optional
- (void)topBarLeftButtonPressed:(UIButton *)button;
- (void)topBarRightButtonPressed:(UIButton *)button;
- (void)topBarExtendButtonPressed:(UIButton *)button;
- (void)topBarDockButtonClicked:(UIButton *)button;

@end

@interface GLTopBarView : UIView

@property (nonatomic, strong) UIView   *backgroundView;
@property (nonatomic, strong) UIView   *bottomLineView;

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) NSString *subTitleText;
@property (nonatomic, strong) UILabel  *subTitleLabel;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *extendButton;

@property (nonatomic, strong) NSString *leftButtonTitle;
@property (nonatomic, strong) NSString *rightButtonTitle;
@property (nonatomic, strong) NSString *extendButtonTitle;

@property (nonatomic, strong) UIImage  *leftButtonImage;
@property (nonatomic, strong) UIImage  *rightButtonImage;
@property (nonatomic, strong) UIImage  *extendButtonImage;

@property (nonatomic, strong) UIButton *dockButton;

@property (nonatomic, assign) GLTopBarStyle topBarStytle;

@property (nonatomic, weak)   id<GLTopBarViewDelegate> delegate;

- (void)addDockButton;

- (id)initWithFrame:(CGRect)frame topBarStyle:(GLTopBarStyle)topBarStyle delegate:(id<GLTopBarViewDelegate>)delegate;

+ (GLTopBarView *)topBarViewWithStyle:(GLTopBarStyle)topBarStyle delegate:(id<GLTopBarViewDelegate>)delegate;

- (void)setRightButtonImage:(UIImage *)rightButtonImage andHighlightedImage:(UIImage *)highlightedImage;

- (void)setExtendButtonImage:(UIImage *)extendButtonImage andHighlightedImage:(UIImage *)highlightedImage;

-(void)setRightButtonFromShareButton:(UIButton *)shareButton;
-(void)setExtendButtonFromShareButton:(UIButton *)shareButton;

@end
