
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
#import "XTOnePixelLine.h"
#import "config.h"

@interface GLPerson ()<NSCoding>

@end

@implementation GLPerson

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.firtName = [aDecoder decodeObjectForKey:@"FirstName"];
        self.lastName = [aDecoder decodeObjectForKey:@"LastName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.firtName forKey:@"FirstName"];
    [aCoder encodeObject:self.lastName forKey:@"LastName"];
}

@end


static NSInteger i = 0;

@interface ButtonDemoVC ()<UITextFieldDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIButton      *myButton;
@property (nonatomic, strong) OButton       *blockButton;
@property (nonatomic, strong) UITextField   *myTextField;
@property (nonatomic, strong) UIImageView   *myImgView;
@property (nonatomic, strong) UILabel       *myLabel;
@property (nonatomic, strong) UIAlertView   *myAlertView;

@property (nonatomic, strong) XTOnePixelLine *onePixelLine;//一像素线

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
    [self addRightButton];
    
    [self addOnePixelLine];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    GLog(@"%@", self);
    
   
}

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

//设置右导航图标
- (void)addRightButton
{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 44, 0, 44, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"icon_nav_more"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)moreButtonClicked:(id)sender
{
   // [self showActionSheetView];
    
    
}

- (void)setMoreTypeView
{
    
    
}

- (void)showActionSheetView
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"解除绑定"                                                                     otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];

}

#pragma mark UI && Events

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

- (void)addOnePixelLine
{
    self.onePixelLine = [[XTOnePixelLine alloc] initWithFrame:CGRectMake(50, 100, 100, 1)];
    self.onePixelLine.lineColor = [UIColor colorwithHexString:@"0x000000"];
   // self.onePixelLine.y = self.myButton.bottom + 20;
    self.onePixelLine.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.onePixelLine.linePosition = GSLinePositionBottom;
    [self.view addSubview:self.onePixelLine];
    
}

#pragma mark delegate 传值实现
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

#pragma mark block 传值实现
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

#pragma mark - NSArchive


#pragma mark textField 自动适应键盘
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if (textField == self.urlTextField) {
//        CGRect frame = textField.frame;
//        int offset = frame.origin.y + 32 - (self.view.height - 216.0f);
//        NSTimeInterval animatioonDuration = 0.3f;
//        [UIView beginAnimations:@"ResizeForKeyboard" context:NULL];
//        [UIView setAnimationDuration:animatioonDuration];
//        
//        if (offset > 0) {
//            self.view.frame = CGRectMake(0.0f, -offset - 50, self.view.width, self.view.height);
//            [UIView commitAnimations];
//        }
//    }
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    if (textField == self.urlTextField)
//    {
//        self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    }
//    

@end
