//
//  AdvertiseView.m
//  Demos
//
//  Created by gaolong on 15/8/13.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "AdvertiseView.h"

@implementation AdvertiseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //initialization here
        CGRect rect     = CGRectMake(0, 0, self.width, self.height);
        self.scrollView = [[UIScrollView alloc] initWithFrame:rect];
        self.scrollView.backgroundColor = [UIColor purpleColor];
        self.scrollView.delegate = self;
        
        //不显示垂直滚动条
        self.scrollView.showsVerticalScrollIndicator = YES;
        //不显示水平滚动条
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        
        //scrollview底部设计容器装载滑动数量统计，
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 20, self.width, 20)];
        
        containerView.backgroundColor = [UIColor clearColor];
        [self addSubview:containerView];
        
        //底部橘黄色装载数据的横条
        UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerView.width, containerView.height)];
        alphaView.backgroundColor = [UIColor orangeColor];
        alphaView.alpha = 0.6;
        [containerView addSubview:alphaView];
        
        //pageControl 即滚动提示条
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, 0, containerView.width - 20, 20)];
        self.pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        self.pageControl.currentPage = 0;
        
        [containerView addSubview:self.pageControl];
        
        //图片数目Label
        self.imageNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, containerView.width - 20, 20)];
        self.imageNumber.font = [UIFont boldSystemFontOfSize:15];
        self.imageNumber.backgroundColor = [UIColor clearColor];
        self.imageNumber.textColor = [UIColor whiteColor];
        self.imageNumber.textAlignment = NSTextAlignmentCenter;
        [containerView addSubview:self.imageNumber];
        
        //配置定时器，scrollView的本质是设置contentSize的宽度或者高度大于scrollView的宽度或者高度，然后就能够滑动
        //然后设置定时器定时滑动到contentSize 的offset.x 或者offset.y 的位置。即实现scorllView动画
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        //关闭定时器
        [self.timer setFireDate:[NSDate distantFuture]];
        
    }
    
    return self;
}

- (void)timerAction:(NSTimer *)timer
{
    if (self.totalNumber > 1) {
        CGPoint newOffset = self.scrollView.contentOffset;
        newOffset.x = newOffset.x + self.scrollView.width;
        //offset 位置大于contentSize时重新设置offset.x
        if (newOffset.x > self.scrollView.width * (self.totalNumber - 1 )) {
            newOffset.x = 0;
        }
        
        //当前是第几个图
        NSInteger index = newOffset.x / self.scrollView.width;
        newOffset.x = index * self.scrollView.width;
        self.imageNumber.text = [NSString stringWithFormat:@"%ld / %ld", index + 1, (long)self.totalNumber];
        [self.scrollView setContentOffset:newOffset animated:YES];
        
    }
    else
    {
        //当只有一张图片时不显示动画
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        //
    }
    else
    {
        NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.width;
        self.pageControl.currentPage = index;
        for (UIView *view in scrollView.subviews) {
            if (view.tag == index) {
                
            }
            else
            {
                //
            }
        }
    }
}

- (void)addArray:(NSArray *)imgageArray
{
    self.totalNumber = [imgageArray count];
    if (self.totalNumber > 0) {
        for (NSInteger i = 0; i < self.totalNumber; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.width * i, 0, self.scrollView.width, self.scrollView.height)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.image = [UIImage imageNamed:imgageArray[i]];
            [imageView setTag:i];
            
            [self.scrollView addSubview:imageView];
        }
        
        self.imageNumber.text = [NSString stringWithFormat:@"%ld / %ld", (long)self.pageControl.currentPage + 1, (long)self.totalNumber];
        self.pageControl.numberOfPages = self.totalNumber;
        CGRect frame = self.pageControl.frame;
        frame.size.width = 15 * self.totalNumber;
        self.pageControl.frame = frame;
        
    }
    else
    {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
        [img setImage:[UIImage imageNamed:@"comment_gray"]];
        img.userInteractionEnabled = YES;
        [_scrollView addSubview:img];
        self.imageNumber.text = @"提示：滚动栏无数据。";
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.totalNumber, self.scrollView.height);
    
}

- (void)openTimer
{
    //开启定时器
    [_timer setFireDate:[NSDate distantPast]];
    
}
- (void)closeTimer
{
    //关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    
}

@end
