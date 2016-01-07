//
//  PassValueBlockVC.m
//  Demos
//
//  Created by gaolong on 15/8/12.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "PassValueBlockVC.h"

@interface PassValueBlockVC ()

@property (nonatomic, strong) NSString *textName;
@property (nonatomic, strong) NSNumber *textNum;
@property (nonatomic, strong) UIButton *gotoButton;

@end

@implementation PassValueBlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addButton];
    
}

- (void)addButton
{
    self.gotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.gotoButton.width = 100;
    self.gotoButton.height = 50;
    self.gotoButton.center = self.view.center;
    [self.gotoButton setTitle:@"委托传值" forState:UIControlStateNormal];
    self.gotoButton.layer.borderWidth = 1.0f;
    [self.gotoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.gotoButton addTarget:self action:@selector(pushTo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.gotoButton];
    
}

- (void)pushTo
{
    if (self) {
        [self.delegate passValueByDelegate:@"你麻痹"];
//         [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"
                                                        message:@"没有成功传值"
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Other", nil];
        [alert show];
    }
    
}

- (void)passValueByBlock:(PassBlock)aBlock
{
    self.textName = @"独孤求败";
    self.textNum  = @90;
    
    if (aBlock) {
        aBlock(self.textName, self.textNum);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
