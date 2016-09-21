//
//  TestUIViewController.m
//  GLTestSpecDemo
//
//  Created by yxt on 16/8/3.
//  Copyright © 2016年 yxt. All rights reserved.
//

#import "TestUIViewController.h"

@interface TestUIViewController ()
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

@end

@implementation TestUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.msgLabel.text = @"花花草草";
    NSLog(@"This is my first Private spec");
    NSLog(@"fuck");
}

@end
