//
//  FifthViewController.m
//  Demos
//
//  Created by schiller on 15/7/20.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "FifthViewController.h"
#import "Masonry.h"

@interface FifthViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *tf;

@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    //[self setOneViewSize];
    //[self setTwoViewSize];
    //[self setTwoViewSpiltSuperView];
    [self setTextFieldView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
   
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [_tf mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardHeight);
    }];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [_tf mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50);
    }];
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

#pragma mark -
#pragma mark show views
- (void)setOneViewSize
{
    __weak typeof(self) weakSelf = self;
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:myView];
    
    [myView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 150));
        make.center.equalTo(weakSelf.view);
    }];
 
}

- (UIView *)setCustomView:(UIColor *)color
{
    UIView *blackView = [UIView new];
    blackView.backgroundColor = color;
    [self.view addSubview:blackView];
    
    return blackView;

}
- (void)setTwoViewSize
{

    UIView *blackView = [self setCustomView:[UIColor blackColor]];
    
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.and.top.mas_equalTo(20);
    }];
    
    UIView *grayView   = [self setCustomView:[UIColor grayColor]];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.and.top.equalTo(blackView);
        make.right.mas_equalTo(-20);
    }];
    
}

- (void)setTwoViewSpiltSuperView
{
     __weak typeof(self) weakSelf = self;
    UIView *blackView = [self setCustomView:[UIColor blackColor]];
    UIView *grayView  = [self setCustomView:[UIColor grayColor]];
    
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    
    }];
    
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.right.mas_equalTo(-20);
        make.height.equalTo(blackView);
        make.top.equalTo(blackView.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.view.mas_centerX).offset(0);

    }];
}

#pragma mark -
#pragma mark test textField
- (void)setTextFieldView
{
    __weak typeof(self) weakSelf = self;
    _tf = [UITextField new];
    _tf.backgroundColor = [UIColor colorWithRed:0.356 green:0.650 blue:0.126 alpha:0.850];
    _tf.delegate = self;
    [self.view addSubview:_tf];
    [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-50);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(weakSelf.view);
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _tf) {
        [_tf resignFirstResponder];
    }
    return  YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
