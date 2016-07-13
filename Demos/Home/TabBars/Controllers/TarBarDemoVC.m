//
//  TarBarDemoVC.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "TarBarDemoVC.h"
#import "Masonry.h"

@interface TarBarDemoVC ()

@property (nonatomic, strong) UILabel *myLabel;

@end

@implementation TarBarDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
