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

@end

@implementation PassValueBlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
