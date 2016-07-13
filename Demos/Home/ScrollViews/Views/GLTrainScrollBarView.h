//
//  GLTrainScrollBarView.h
//  Demos
//
//  Created by schiller on 15/9/15.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TypeSwitchedBlock)(NSInteger selectedIndex);

@interface GLTrainScrollBarView : UIView

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIFont  *titleFont;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, copy) TypeSwitchedBlock switchedBlock;

- (void)updateSelectedIndex:(NSInteger)selectedIndex scrollToLeft:(BOOL)scrollToLeft;
- (void)updateWithTrainTicketInfoArray:(NSArray *)trainInfoArray;

@end
