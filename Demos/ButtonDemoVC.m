
//
//  ButtonDemoVC.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "ButtonDemoVC.h"
#import "RootViewController.h"
#import "OButton.h"

static NSInteger i = 0;

@interface ButtonDemoVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton      *myButton;
@property (nonatomic, strong) OButton       *blockButton;
@property (nonatomic, strong) UITextField   *myTextField;
@property (nonatomic, strong) UIImageView   *myImgView;
@property (nonatomic, strong) UILabel       *myLabel;
@property (nonatomic, strong) UIAlertView   *myAlertView;

@end

@implementation ButtonDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addLeftBackButton];
    [self addImageView];
    [self addTextField];
    [self addLabel];
    [self addButton];
    [self addBlockButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
   
}
#pragma mark - 
#pragma mark block 传值实现
/** 传值*/
- (void)passMessage
{
    if (self.passMsgBlock && self.myTextField.text)
    {
        self.passMsgBlock(self.myTextField.text);
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)addBlockButton
{
    self.blockButton = [OButton buttonWithType:UIButtonTypeCustom];
    self.blockButton.frame = CGRectMake(self.myButton.x - self.myButton.width - 20, self.myButton.y, self.myButton.width, self.myButton.height);
    [self.blockButton setTitle:@"Block" forState:UIControlStateNormal];
    [self.blockButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.blockButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:self.blockButton];
    [self.blockButton addTarget:self action:@selector(passMessage) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark -
#pragma mark delegate 传值实现

/** 自定义leftBarButtonItem的backButton*/
- (void)addLeftBackButton
{
    self.navigationItem.hidesBackButton = YES;
    UIButton *backButton = [UIButton buttonWithType:101];//101和系统自带的返回按钮一致
    [backButton addTarget:self action:@selector(passTextDelegate) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButton;

}

/** delegate 传值*/
- (void)passTextDelegate
{
    if ([self.delegate respondsToSelector:@selector(passValues:)])
    {
        [self.delegate passValues:self.myTextField.text];
        //NSLog(@"%@", self.myTextField.text);
        [self pushToRootVC];
        
    }else
    {
        mAlert(@"提示", @"请输入文字", @"Cancel", @"OK");
        
    }
    
}

/** 随意页面跳转方法*/
- (void)pushToRootVC
{
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[RootViewController class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
}

#pragma mark - 
#pragma mark 基本UI

/** 隐藏键盘*/
- (void)dismissKeyboard
{
      [self.myTextField resignFirstResponder];
}

- (void)addButton
{
    self.myButton         = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myButton.frame   = CGRectMake(0, self.myLabel.bottom + 20 , 60, 60);
    self.myButton.centerX = self.view.centerX;

    [self.myButton setTitle:@"点击" forState:UIControlStateNormal];
    [self.myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.myButton.layer.cornerRadius    = 30;
    self.myButton.layer.backgroundColor = [UIColor colorWithRed:0.379 green:0.799 blue:0.444 alpha:1.000].CGColor;
    [self.myButton addTarget:self action:@selector(showAlertView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myButton];
}

- (void)showAlertView
{
    NSUserDefaults *text = [NSUserDefaults standardUserDefaults];
    NSString *msg = [text objectForKey:@"textfield"];
    self.myLabel.text = self.myTextField.text;
    i++;
    
    if (i >= 5) {
        self.myAlertView = [[UIAlertView alloc] initWithTitle:@"Warn"
                                                      message:msg
                                                     delegate:nil
                                            cancelButtonTitle:@"clear all"
                                            otherButtonTitles:@"continue", nil];
        [self.myAlertView show];
        
        i = 0;
    }
    
}

- (void)addTextField
{
    self.myTextField = [[UITextField alloc] initWithFrame: CGRectMake(0, self.myImgView.bottom + 10, self.view.width/3 + 30, 40)];
    self.myTextField.placeholder = @"write here...";
    
    self.myTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.myTextField.centerX     = self.view.centerX;
    self.myTextField.clearButtonMode =  UITextFieldViewModeAlways;
    self.myTextField.delegate    = self;
    NSUserDefaults *text = [NSUserDefaults standardUserDefaults];
    [text setObject:self.myTextField.text forKey:@"textfield"];

    [self.view addSubview:self.myTextField];
    
}

- (void)addImageView
{
    CGFloat mheight = self.navigationController.navigationBar.frame.size.height;
    self.myImgView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, mheight + 30., self.view.width/3 + 30, self.view.width/3)];
    self.myImgView.centerX = self.view.centerX;
    self.myImgView.image   = [UIImage imageNamed:@"dog"];
    
    [self.view addSubview:self.myImgView];
}

- (void)addLabel
{
    self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.myTextField.bottom + 10 , self.myTextField.width, self.myTextField.height)];
    self.myLabel.centerX = self.view.centerX;
    
    self.myLabel.layer.borderWidth   = 1;
    self.myLabel.layer.cornerRadius  = 5;
    self.myLabel.layer.shadowColor   = [UIColor brownColor].CGColor;
    self.myLabel.layer.shadowOpacity = 1.0;
    self.myLabel.layer.shadowRadius  = 5.0;
    self.myLabel.layer.shadowOffset  = CGSizeMake(0, 3);
    self.myLabel.clipsToBounds       = NO;
    
    NSUserDefaults *text = [NSUserDefaults standardUserDefaults];
    self.myLabel.text    = [text objectForKey:@"textfield"];

    self.myLabel.textAlignment = NSTextAlignmentCenter;
    self.myLabel.textColor = [UIColor blackColor];
    [self.view addSubview:self.myLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.myTextField) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    if ([self.myTextField.text length] > 0 || [self.myTextField.text isEqualToString:@""])
//    {
//        self.myLabel.text = @"";
//    }

    i++;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    i++;
}
@end
