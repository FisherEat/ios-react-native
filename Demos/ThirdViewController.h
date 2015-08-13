//
//  ThirdViewController.h
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NSString*(^aBlock)(NSString * ,NSUInteger);
typedef  void*(sliderBlock)(float, NSNumber *);

@interface ThirdViewController : UIViewController

@property (nonatomic, copy) aBlock testBlock;

- (void)testBlock:(aBlock)changeNumberBlock;

- (void)getSliderValue:(sliderBlock) sliderBlock;

@end
