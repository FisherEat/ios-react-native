//
//  TarBarDemoVC.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "TarBarDemoVC.h"
#import "PickerViewDemoVC.h"
#import "Masonry.h"

@interface TarBarDemoVC ()

@property (nonatomic, strong) UILabel *myLabel;
@property (nonatomic, strong) PickerViewDemoVC *pickViewDemo;

@end

@implementation TarBarDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //[self addLabel];
    [self loadData];
}

- (void)addLabel
{
    __weak typeof (self) weakSelf = self;
    self.myLabel = [[UILabel alloc] init];
    [self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100,30));
        make.center.equalTo(weakSelf.view);
    }];
    [self.view addSubview:self.myLabel];
}

- (void)loadData
{
    __block NSString *info = @"";
    __block float num = 0;
    self.pickViewDemo = [[PickerViewDemoVC alloc] init];
    [self.pickViewDemo changeValueSlider:^(NSString *infoString, NSNumber *value) {
        info = infoString;
        num  = value.floatValue;
    }];
    
    PickerViewDemoVC *picker = [[PickerViewDemoVC alloc] init];
    picker.passBlock = ^(NSString *info ,NSNumber *num)
    {
        NSLog(@"info = %@, num = %@", info, num);
    };
   // NSLog(@"The info string is %@, the slider value = %f", info, num);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
