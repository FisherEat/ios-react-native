//
//  GLMantleViewController.m
//  Demos
//
//  Created by schiller on 16/7/7.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLMantleViewController.h"
#import "GLMantleModel.h"

@implementation GLMantleViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
}

- (void)loadData
{
    [GLCommunityTripActivity communityTripChannelActivity:^(GLCommunityTripActivity *response, NSError *error) {
        if (response) {
            NSLog(@"....%@......", response);
        }
    }];
}

@end
