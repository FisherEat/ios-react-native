//
//  GLUserRegisterView.m
//  Demos
//
//  Created by gaolong on 16/1/5.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLUserRegisterView.h"

@interface GLUserRegisterView ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *passwdLabel;
@property (nonatomic, strong) UITextField *usernameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, copy) NSString *name;
@property (nonatomic ,copy) NSString *password;

@end

@implementation GLUserRegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    [self addSubview:self.nameLabel];
    [self addSubview:self.usernameTF];
    [self addSubview:self.passwdLabel];
    [self addSubview:self.passwordTF];
}

- (UILabel *)setNameLabel
{
    if (!_nameLabel) {
        _nameLabel =[UILabel new];
    }
    return _nameLabel;
}

@end
