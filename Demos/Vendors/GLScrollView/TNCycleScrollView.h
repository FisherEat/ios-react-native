//
//  TNCycleScrollView.h
//  TuNiuApp
//
//  Created by zhaofeng on 14-6-4.
//  Copyright (c) 2014年 Tuniu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNCycleScrollView : UIView

@property (nonatomic , readonly) UIScrollView *scrollView;
/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

- (void)addPageChangedHandler:(void (^)(NSInteger pageNum))actionHandler;

- (void)reloadScrollViewData;
- (void)moveToIndex:(NSInteger)lastestIndex;

- (void)stopAnimation;

@end
