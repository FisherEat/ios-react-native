//
//  GLThreadViewController.m
//  Demos
//
//  Created by gaolong on 16/7/4.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLThreadViewController.h"
#import "GLThreadDataSource.h"

@interface GLThreadViewController ()

@end

@implementation GLThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [GLThreadDataSource runInSyncThread];
    
//    [GLThreadDataSource blockInSyncThread];
    
    [GLThreadDataSource groupThreads];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
