//
//  PickerViewDemoVC.h
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sliderBlock)(NSString * , NSNumber *);
@interface PickerViewDemoVC : UIViewController

@property (nonatomic, strong) UILabel  *myLabel;

@property (nonatomic, copy) sliderBlock passBlock;

- (void)changeValueSlider:(sliderBlock)aBlock;

@end
