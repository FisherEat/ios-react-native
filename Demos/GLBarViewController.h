//
//  GLBarViewController.h
//  Demos
//
//  Created by schiller on 15/8/27.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNTopBarView.h"

@interface GLBarViewController : UIViewController<TNTopBarViewDelegate>

@property(nonatomic, strong) TNTopBarView *topBarView;

//将左侧按钮设置成返回按钮
- (void)setLeftButtonToBackButton;

@end
