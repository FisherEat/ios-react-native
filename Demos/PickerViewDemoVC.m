//
//  PickerViewDemoVC.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "PickerViewDemoVC.h"
#import "CNPPopupController.h"

@interface PickerViewDemoVC ()<UIPickerViewDataSource,UIPickerViewDelegate,CNPPopupControllerDelegate>

@property (nonatomic, strong) UIButton     *myButton;
@property (nonatomic, strong) UIDatePicker *myDatePicker;
@property (nonatomic, strong) UILabel      *myLabel;
@property (nonatomic, strong) CNPPopupController *popupController;

@end

@implementation PickerViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addButton];
    [self addLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
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
    [self.myButton addTarget:self action:@selector(showPopupView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myButton];
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

#pragma mark pickerview delegate

#pragma mark - CNPPopupController Delegate

- (void)popupController:(CNPPopupController *)controller didDismissWithButtonTitle:(NSString *)title {
    NSLog(@"Dismissed with button title: %@", title);
}

- (void)popupControllerDidPresent:(CNPPopupController *)controller {
    NSLog(@"Popup controller presented.");
}



@end
