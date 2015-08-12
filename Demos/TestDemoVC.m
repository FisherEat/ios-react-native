//
//  TestDemoVC.m
//  Demos
//
//  Created by schiller on 15/7/22.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "TestDemoVC.h"
#import "PassValueBlockVC.h"

@interface TestDemoVC ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end

@implementation TestDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    PassValueBlockVC *passValueVC = [[PassValueBlockVC alloc] init];
    
    __weak typeof(self) weakSelf = self;
    [passValueVC passValueByBlock:^(NSString *string, NSNumber *num) {
        weakSelf.name = string;
        weakSelf.age  = num.integerValue;
        
    }];
    
    NSLog(@"The name and the age is(test demovc)%@, %ld", self.name, self.age);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
