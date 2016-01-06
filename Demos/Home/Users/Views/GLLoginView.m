//
//  GLLoginView.m
//  Demos
//
//  Created by gaolong on 16/1/1.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLLoginView.h"

@interface GLLoginView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *passwdLabel;
@property (nonatomic, strong) UITextField *usernameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;

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
    _nameLabel = [UILabel new];
    _nameLabel.text = @"用户名:";
    [self addSubview:_nameLabel];

    _passwdLabel = [UILabel new];
    _passwdLabel.text = @"密  码:";
    _passwdLabel.textColor = _nameLabel.textColor =  HEXCOLOR(0x333333);
    _passwdLabel.font = _nameLabel.font = APP_FONT(16);
    [self addSubview:_passwdLabel];
    
    _usernameTF = [UITextField new];
    _usernameTF.placeholder = @"请输入用户名";
    _usernameTF.textColor = HEXCOLOR(0x666666);
    _usernameTF.delegate = self;
    [self addSubview:_usernameTF];
    
    _passwordTF = [UITextField new];
    _passwordTF.placeholder = @"请输入密码";
    _passwordTF.font = _usernameTF.font = APP_FONT(14);
    _passwordTF.layer.borderWidth = _usernameTF.layer.borderWidth = 1;
    _passwordTF.layer.borderColor = _usernameTF.layer.borderColor = HEXCOLOR(0x999999).CGColor;
    _passwordTF.layer.cornerRadius = _usernameTF.layer.cornerRadius = 5;
    _passwordTF.delegate = self;
    [self addSubview:_passwordTF];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitle:@"登   陆" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = APP_FONT(16);
    [_loginBtn setBackgroundColor:HEXCOLOR(0x008b8b)];
    _loginBtn.layer.cornerRadius = 5;
    [_loginBtn addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginBtn];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerBtn setTitle:@"注   册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    _registerBtn.titleLabel.font = APP_FONT(16);
    [_registerBtn setBackgroundColor:HEXCOLOR(0xff7f50)];
    _registerBtn.layer.cornerRadius = 5;
    [self addSubview:_registerBtn];
}

- (void)layoutSubviews
{
    _nameLabel.frame = CGRectMake(50, 20, 100, 50);
    [_nameLabel sizeToFit];
    _passwdLabel.frame = CGRectMake(50, 0, 100, 50);
    _passwdLabel.y = _nameLabel.bottom + 30;
    [_passwdLabel sizeToFit];
    
    _usernameTF.frame = CGRectMake(0, 0, 200, 30);
    _usernameTF.x = _nameLabel.right + 10;
    _usernameTF.centerY = _nameLabel.centerY;
    
    _passwordTF.frame = CGRectMake(0, 0, 200, 30);
    _passwordTF.x = _usernameTF.x;
    _passwordTF.centerY = _passwdLabel.centerY;
    
    _loginBtn.frame = CGRectMake(0, 0,150, 40);
    _loginBtn.x = _passwdLabel.x;
    _loginBtn.y = _passwordTF.bottom + 10;
    
    _registerBtn.frame = CGRectMake(0, 0, 150, 40);
    _registerBtn.x = _loginBtn.right + 10;
    _registerBtn.centerY = _loginBtn.centerY;
    
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

@end
