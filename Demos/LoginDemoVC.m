//
//  LoginDemoVC.m
//  Demos
//
//  Created by schiller on 15/8/19.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "LoginDemoVC.h"

@interface LoginDemoVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField   *textField;
@property (nonatomic, strong) UILabel       *textLabel;
@property (nonatomic, strong) UIButton      *clickButton;

@end

@implementation LoginDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Login";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addUIs];
}

- (void)addUIs
{
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, self.view.width / 1.5, 60)];
    self.textField.centerX = self.view.centerX ;
    self.textField.placeholder = @"write here";
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    self.clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clickButton setTitle:@"确认" forState:UIControlStateNormal];
//    [self.clickButton setTitleColor:[uico] forState:<#(UIControlState)#>]
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
