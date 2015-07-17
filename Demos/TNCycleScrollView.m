//
//  TNCycleScrollView.m
//  TuNiuApp
//
//  Created by zhaofeng on 14-6-4.
//  Copyright (c) 2014年 Tuniu. All rights reserved.
//

#import "TNCycleScrollView.h"
#import "NSTimer+Addition.h"

@interface TNCycleScrollView () <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, assign) NSInteger totalPageCount;
@property (nonatomic, strong) NSMutableArray *contentViews;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, copy) void (^pageChangedHandler)(NSInteger pageNum);

@end

@implementation TNCycleScrollView

- (void)reloadScrollViewData
{
    self.currentPageIndex = 0;
    if (self.pageChangedHandler) {
        self.pageChangedHandler(self.currentPageIndex);
    }
}

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPageCount = totalPagesCount();
    if (_totalPageCount > 0) {
        [self configContentViews];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}

//- (void)setUpPageControlWithFrame:(CGRect)

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
    }
    return self;
}

- (void)moveToIndex:(NSInteger)lastestIndex
{
    if ((lastestIndex < self.totalPageCount) && lastestIndex >= 0)
    {
        self.currentPageIndex = lastestIndex;
        [self configContentViews];
    }
    
}

#pragma mark -
#pragma mark - 私有函数

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        if (nil == contentView) {
            return;
        }
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    [_scrollView setContentOffset:CGPointMake( _scrollView.frame.size.width, 0)];
}

// 复制视图的方法 add by xukaiwei 2015.05.29
- (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        UIView *tmpView1 = self.fetchContentViewAtIndex(previousPageIndex);
        UIView *tmpView2 = self.fetchContentViewAtIndex(_currentPageIndex);
        UIView *tmpView3 = self.fetchContentViewAtIndex(rearPageIndex);
        /* add by xukaiwei 2015.05.29
         / function: 修复轮播数量小于三个时候，轮播空白的问题
         / 问题根源：当数量小于3时候，由于self.contentViews保存的3个视图肯定有重复一样的视图，那么在执行[self.scrollView addSubview:aview]的时候，插入相同的视图是无效的，所以self.scrollView的子视图实际上是不足3个的，导致现实错误。
         / 解决思路：为了让相同的视图能顺利添加到父视图，将获取的视图在内存中拷贝一份。这样就能顺利添加相同的视图了。
         */
        if (previousPageIndex == _currentPageIndex) {
            tmpView1 = [self duplicate:tmpView2];
        }
        if (rearPageIndex == _currentPageIndex) {
            tmpView3 = [self duplicate:tmpView2];
        }
        if (tmpView1) {
            [self.contentViews addObject:tmpView1];
        }
        if (tmpView2) {
            [self.contentViews addObject:tmpView2];
        }
        if (tmpView3) {
            [self.contentViews addObject:tmpView3];
        }
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

- (void)addPageChangedHandler:(void (^)(NSInteger pageNum))actionHandler;
{
    self.pageChangedHandler = actionHandler;
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
//        DLog(@"next，当前页:%d",self.currentPageIndex);
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
//        NSLog(@"previous，当前页:%d",self.currentPageIndex);
        [self configContentViews];
    }
    
    if (self.pageChangedHandler) {
        self.pageChangedHandler(self.currentPageIndex);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}


- (void)stopAnimation
{
    [self.animationTimer invalidate];
    self.animationTimer = nil;
}
@end
