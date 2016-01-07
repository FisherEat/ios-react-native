//
//  GLLoginView.m
//  Demos
//
//  Created by gaolong on 16/1/1.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLLoginView.h"
#import "PersonModel.h"
@interface GLLoginView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *passwdLabel;
@property (nonatomic, strong) UITextField *usernameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, copy) NSString *name;
@property (nonatomic ,copy) NSString *password;

@end

@implementation GLLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    [self addSubview:self.nameLabel];
    [self addSubview:self.passwdLabel];
    [self addSubview:self.usernameTF];
    [self addSubview:self.passwordTF];
    [self addSubview:self.loginBtn];
    [self addSubview:self.registerBtn];
    [self addSubview:self.bgImageView];
    [self setUpConstraints];
}

- (void)setUpConstraints
{
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:50];
    [self.nameLabel autoSetDimension:ALDimensionWidth toSize:80];
   
    [self.usernameTF autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.nameLabel withOffset:10];
    [self.usernameTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
    [self.usernameTF autoSetDimension:ALDimensionHeight toSize:30];
    [self.usernameTF autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
  
    [self.passwdLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nameLabel];
    [self.passwdLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.nameLabel];
    [self.passwdLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:20];
  
    [self.passwordTF autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.usernameTF];
    [self.passwordTF autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.passwdLabel];
    [self.passwordTF autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.usernameTF];
    [self.passwordTF autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.usernameTF];
    
    [self.loginBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.passwdLabel];
    [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.passwdLabel withOffset:20];
    [self.loginBtn autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.registerBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.passwordTF];
    [self.registerBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.loginBtn];
    [self.registerBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.loginBtn];
    [self.registerBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.loginBtn];
    [self.loginBtn autoSetDimension:ALDimensionWidth toSize:120 relation:NSLayoutRelationLessThanOrEqual];
    [self.loginBtn autoSetDimension:ALDimensionWidth toSize:100 relation:NSLayoutRelationGreaterThanOrEqual];
    
    [self.bgImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.loginBtn withOffset:20];
    [self.bgImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.bgImageView autoSetDimensionsToSize:CGSizeMake(100, 100)];
}

- (void)bindData:(PersonData *)data
{
    if (data && data.urlString) {
        [_bgImageView gl_setImageWithURL:[NSURL URLWithString:data.urlString] option:GLWebImageOptionsRetryFailed placeholderImage:[UIImage imageNamed:@"c"] ompleted:^(UIImage *image, NSError *error, NSURL *imageURL) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(downLoadImage:url:error:)]) {
                [self.delegate downLoadImage:image url:imageURL error:error];
            }
        }];
    }else {
        
    }
}

- (void)loginButtonClicked
{
    if (self.name && self.password) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loginWithName:password:)]) {
            [self.delegate loginWithName:self.usernameTF.text password:self.passwordTF.text];
        }else {
            
        }
    }else {
        mAlert(@"提示", @"请输入用户名或者密码", @"取消", @"确认");
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _usernameTF) {
        self.name = textField.text;
    }else if (textField == _passwordTF) {
        self.password = textField.text;
    }else {
        
    }
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = HEXCOLOR(0x333333);
        _nameLabel.font = APP_FONT(16);
        _nameLabel.text = @"用户名：";
    }
    return _nameLabel;
}

- (UILabel *)passwdLabel
{
    if (!_passwdLabel) {
        _passwdLabel = [UILabel new];
        _passwdLabel.textColor = HEXCOLOR(0x333333);
        _passwdLabel.font = APP_FONT(16);
        _passwdLabel.text = @"密   码：";
    }
    return _passwdLabel;
}

- (UITextField *)usernameTF
{
    if (!_usernameTF) {
        _usernameTF = [UITextField new];
        _usernameTF.textColor = HEXCOLOR(0x666666);
        _usernameTF.font = APP_FONT(14);
        _usernameTF.layer.borderWidth = 1;
        _usernameTF.layer.cornerRadius = 4;
        _usernameTF.placeholder = @"请输入用户名";
        _usernameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _usernameTF.delegate = self;
    }
    return _usernameTF;
}

- (UITextField *)passwordTF
{
    if (!_passwordTF) {
        _passwordTF = [UITextField new];
        _passwordTF.textColor = HEXCOLOR(0x666666);
        _passwordTF.font = APP_FONT(14);
        _passwordTF.layer.borderWidth = 1;
        _passwordTF.layer.cornerRadius = 4;
        _passwordTF.placeholder = @"请输入密码";
        _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTF.delegate = self;
    }
    return _passwordTF;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登   录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:HEXCOLOR(0x008b8b)];
        _loginBtn.titleLabel.font =APP_FONT(16);
        _loginBtn.layer.cornerRadius = 5;
        [_loginBtn addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)registerBtn
{
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注   册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        [_registerBtn setBackgroundColor:HEXCOLOR(0xff7f50)];
        _registerBtn.layer.cornerRadius = 5;
        _registerBtn.titleLabel.font = APP_FONT(16);
        [_registerBtn addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [UIImageView newAutoLayoutView];
    }
    return _bgImageView;
}
@end
