//
//  AdScrollTimerViewController.m
//  Demos
//
//  Created by gaolong on 15/8/13.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "AdScrollTimerViewController.h"
#import "AdvertiseView.h"

@interface AdScrollTimerViewController ()

@property (nonatomic, strong) AdvertiseView *adVertiseView;

@end

@implementation AdScrollTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect rect = CGRectMake(5, 64, self.view.width, 150);
    self.adVertiseView = [[AdvertiseView alloc] initWithFrame:rect];
    NSArray *imageNames = @[@"juhua.png",@"mudan.png",@"youcaihua.png",@"yujinxiang.png",@"gesanghua.png",@"shuixianhua.png"];
    self.adVertiseView.backgroundColor = [UIColor whiteColor];
    [self.adVertiseView addArray:imageNames];
    
    [self.view addSubview:self.adVertiseView];
}

# pragma mark 定时滚动scrollView
-(void)viewDidAppear:(BOOL)animated
{
    //显示窗口
    [super viewDidAppear:animated];
    
    //[NSThread sleepForTimeInterval:3.0f];//睡眠，所有操作都不起作用
    //开启定时器
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),
                   ^{
                       [self.adVertiseView openTimer];
                   });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

