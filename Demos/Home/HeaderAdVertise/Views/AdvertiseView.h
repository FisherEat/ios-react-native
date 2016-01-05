//
//  AdvertiseView.h
//  Demos
//
//  Created by gaolong on 15/8/13.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertiseView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel       *imageNumber;
@property (nonatomic, assign) NSInteger     totalNumber;

- (void)addArray:(NSArray *)imgageArray;
- (void)openTimer;
- (void)closeTimer;

@end
