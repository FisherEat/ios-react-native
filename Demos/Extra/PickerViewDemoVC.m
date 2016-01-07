//
//  PickerViewDemoVC.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "PickerViewDemoVC.h"
#import "CNPPopupController.h"
#import "CommonCrypto/CommonDigest.h"

static NSInteger i = 1;

@interface PickerViewDemoVC ()<UIPickerViewDataSource,UIPickerViewDelegate,CNPPopupControllerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIButton     *myButton;
@property (nonatomic, strong) UIDatePicker *myDatePicker;
@property (nonatomic, strong) CNPPopupController *popupController;
@property (nonatomic, strong) UITextField  *tfRegex;
@property (nonatomic, strong) UISlider     *mySlider;
@property (nonatomic, strong) NSNumber     *sliderValue;

@end

@implementation PickerViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addButton];
    [self addLabel];
    [self setBackButton];
    [self addTextField];
    [self addSlider];
    NSString *str = [self md5:@"1320681113@qq.com"];
    NSLog(@"%@", str);
    [self testBlock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)addSlider
{
    self.mySlider = [[UISlider alloc] init];
    self.mySlider.center = self.view.center;
    self.mySlider.width = 200;
    self.mySlider.height = 20;
    [self.view addSubview:self.mySlider];
    [self.mySlider addTarget:self action:@selector(testBlock) forControlEvents:UIControlEventValueChanged];
    
}

- (void)changeValue:(UISlider *)sender
{
    if (self.mySlider == sender) {
        NSLog(@"%@", @(self.mySlider.value));
        self.sliderValue = @(sender.value);
    }
    
    __block NSString *infoMgs = @"just want to pass the value of the slider to you.";
    if (self.passBlock) {
        
        self.passBlock(infoMgs, @(sender.value));
    }
}

- (void)changeValueSlider:(sliderBlock)aBlock
{
    i++;
    __weak typeof(self) weakSelf = self;
    __block NSNumber *value = @0;
    __block NSString *error = @"error is nil";
    if (aBlock) {
        weakSelf.sliderValue = @(weakSelf.mySlider.value);
       // value = weakSelf.sliderValue;
        value = @(i);
        aBlock(error, value);
    }
    else
    {
        NSLog(@"error happened.");
    }
    
}

- (void)testBlock
{
    __block NSString *str = @"ok";
    __block NSNumber *num = @90;
    if (self.passBlock) {
        
        self.passBlock(str, num);
    }
    
}
#pragma mark 测试正则式子匹配功能

//email
- (BOOL)testEmailRegexExpression:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

//telephone
- (BOOL)validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9]|(18[0,0-9]))\\d{8}$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

- (void)test
{
    if ([self testEmailRegexExpression:self.tfRegex.text])
    {
        NSLog(@"email 正则表达式符合要求 %@", self.tfRegex.text);
    }else
    {
        NSLog(@"email 格式不正确");
    }
    
    if ([self validateMobile:self.tfRegex.text]) {
        NSLog(@"mobile phone nubmer is right, %@", self.tfRegex.text);
    }else
    {
        NSLog(@"手机号格式不正确");
    }
    
}

#pragma mark - MD5 test 
- (NSString *)md5:(NSString *)inPutText
{
    return nil;
}

#pragma mark - test notification
- (void)postNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCalendarFromView" object:self.myLabel.text];
}

- (void)setBackButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(self.myButton.x - 80, self.myButton.y, 40, 40);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
}

- (void)pushBack
{
    [self postNotification];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addButton
{
    CGFloat height = self.navigationController.navigationBar.height;
    self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.myButton.frame   = CGRectMake(0,height + 50, 60, 60);
    self.myButton.centerX = self.view.centerX;
    
    [self.myButton setTitle:@"点击" forState:UIControlStateNormal];
    [self.myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.myButton.layer.cornerRadius    = 30;
    self.myButton.layer.backgroundColor = [UIColor colorWithRed:0.379 green:0.799 blue:0.444 alpha:1.000].CGColor;
 
    //测试正则表达式
    [self.myButton addTarget:self
                      action:@selector(test)
            forControlEvents:UIControlEventTouchUpInside];
   // [self.myButton addTarget:self action:@selector(showPopupView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myButton];
}

- (void)addTextField
{
    self.tfRegex = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    self.tfRegex.centerX = self.view.centerX;
    self.tfRegex.y = self.myLabel.bottom + 20;
    self.tfRegex.layer.borderColor = [UIColor greenColor].CGColor;
    self.tfRegex.layer.borderWidth = 2.0f;
    self.tfRegex.delegate = self;
    [self.view addSubview:self.tfRegex];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (void)showPopupView
{
    [self showPopupWithStyle:CNPPopupStyleCentered];

}

- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
   
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"请选择日期" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
       CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"选好了亲" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler   = ^(CNPPopupButton *button)
    {
        [self.popupController dismissPopupControllerAnimated:YES];
        [self showDate];
        NSLog(@"Block for button: %@", button.titleLabel.text);
    };
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.attributedText = title;
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 255, 255)];
    customView.backgroundColor = [UIColor lightGrayColor];

    /**
     set datapicker view
     
     */
    self.myDatePicker   = [[UIDatePicker alloc] initWithFrame: CGRectMake(0, 0, customView.width - 30, customView.height)];
    self.myDatePicker.centerX = customView.centerX;
    self.myDatePicker.datePickerMode = UIDatePickerModeDate;//模式选择
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    self.myDatePicker.locale = locale;
    
    [customView addSubview:self.myDatePicker];
    
    self.popupController      = [[CNPPopupController alloc] initWithContents:@[titleLabel, customView, button]];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = popupStyle;
    self.popupController.delegate = self;
    [self.popupController presentPopupControllerAnimated:YES];
    
}

- (void)showDate
{

    NSDate *selected = [self.myDatePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    //NSDate *selectedDate = self.myDatePicker.date;
    self.myLabel.text = [NSString stringWithFormat:@"日期:%@", destDateString];
    
}

- (void)addLabel
{
    self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.myButton.bottom + 10 , self.view.width/2 + 50, 50)];
    self.myLabel.centerX = self.view.centerX;
    
    self.myLabel.layer.borderWidth   = 1;
    self.myLabel.layer.cornerRadius  = 5;
    self.myLabel.layer.shadowColor   = [UIColor brownColor].CGColor;
    self.myLabel.layer.shadowOpacity = 1.0;
    self.myLabel.layer.shadowRadius  = 5.0;
    self.myLabel.layer.shadowOffset  = CGSizeMake(0, 3);
    self.myLabel.clipsToBounds       = NO;
    
    self.myLabel.textAlignment = NSTextAlignmentCenter;
    self.myLabel.textColor = [UIColor blackColor];
    [self.view addSubview:self.myLabel];
    
    
}

#pragma mark pickerview datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 12;
}

#pragma mark - CNPPopupController Delegate

- (void)popupController:(CNPPopupController *)controller didDismissWithButtonTitle:(NSString *)title {
    NSLog(@"Dismissed with button title: %@", title);
}

- (void)popupControllerDidPresent:(CNPPopupController *)controller {
    NSLog(@"Popup controller presented.");
}

@end
