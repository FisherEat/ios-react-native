//
//  ScrollDemoVC.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "ScrollDemoVC.h"
#import "POP.h"

@interface ScrollDemoVC ()<UIScrollViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *topView;
@property (nonatomic, strong) UIView       *dogview;
@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UIView       *alpaView;
@property (nonatomic, strong) UIButton     *leftButton;
@property (nonatomic, strong) UIButton     *leftChangeButton;
@property (nonatomic, strong) UISearchBar  *searchBar;

@end

@implementation ScrollDemoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden     = YES;

    [self initScrollView];

    self.alpaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kNavigationBarHeight)];
    self.alpaView.backgroundColor = [UIColor colorWithWhite:0.880 alpha:1.000];
    UIView *bottomLineView = [[UIView alloc] initWithFrame:kTNTopBarLineRect];
    bottomLineView.backgroundColor = [UIColor colorWithRed:198 green:198 blue:198 alpha:1];
    [self.view addSubview:self.alpaView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 2 )];
    self.imageView.image = [UIImage imageNamed:@"mydog"];
    [self.scrollView addSubview:self.imageView];
    
    [self addScrollTopButton];
    [self addSearchbarView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]   initWithTarget:self action:@selector(dismissTheKeyboard)];
    [self.view addGestureRecognizer:tap];

    
}

- (void)dismissTheKeyboard
{
    [self.searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark 自定义顶部视图的按钮、搜索框等控件

- (void)initScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //scrollView 可滑动区域大小，必须大于scroll高度方可滑动
    self.scrollView.contentSize    = CGSizeMake(self.view.width, self.view.height * 3);
    //允许下拉效果
    self.scrollView.bounces        = YES;
    //NO 则为均匀滑动
    self.scrollView.pagingEnabled  = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate       = self;
    
    [self.view addSubview:self.scrollView];
    
}

- (void)addScrollTopButton
{
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"tool_bar_icon_phone"] forState:UIControlStateNormal];
    self.leftButton.frame = CGRectMake(25, 25, 25,25);
    [self.view addSubview:self.leftButton];
    
    self.leftChangeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftChangeButton setBackgroundImage:[UIImage imageNamed:@"home_call_normal"] forState:UIControlStateNormal];
    self.leftChangeButton.frame = self.leftButton.frame;
    [self.view addSubview:self.leftChangeButton];
    
}

- (void)addSearchbarView
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(self.leftButton.right + 20, self.leftButton.y, self.view.width * 0.65, self.leftButton.height)];
    [self removeMySearchbar];
    self.searchBar.backgroundColor = [UIColor clearColor];
    self.searchBar.placeholder = @"search";
    self.searchBar.delegate = self;
    
    [self.view addSubview:self.searchBar];
    
}

- (void)removeMySearchbar
{
    for (UIView *views in self.searchBar.subviews) {
        if ([views isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [views removeFromSuperview];
            break;
        }
        if ([views isKindOfClass:NSClassFromString(@"UIView")]&&views.subviews.count > 0) {
            [[views.subviews objectAtIndex:0]removeFromSuperview];
            break;
        }
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
    UIButton *cancleButton ;
    UIView *topView = self.searchBar.subviews[0];
    for (UIView *views in topView.subviews) {
        if ([views isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            cancleButton = (UIButton *)views;
        }
    }
    if (cancleButton) {
        [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        cancleButton.tintColor = [UIColor grayColor];
    }
    
}

#pragma mark -
#pragma mark ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollView == scrollView) {
        
        NSLog(@"%@", NSStringFromCGPoint(self.scrollView.contentOffset));
    
        CGFloat alpha = (self.scrollView.contentOffset.y + 40) * 0.005;
        self.alpaView.alpha = alpha >1.0f?1.0f:alpha;

        self.leftButton.alpha = (1.0 - alpha)< 0.0?0.0:(1-alpha);
        self.leftChangeButton.alpha = alpha >1.0f?1.0f:alpha;
        
        NSLog(@"%f", self.alpaView.alpha);
        static CGFloat oldY = 0;
        CGFloat newY = scrollView.contentOffset.y;
        
        if (newY > oldY)
        {
            // 向上滚动
            oldY = newY;
            if (newY>=0) {
                // 显示
                [UIView animateWithDuration:0.5 animations:^{
                    //self.alpaView.alpha = 1.0;
                    self.searchBar.alpha = 1;
                }];
            }
        }
        else if (newY < oldY)
        {
            // 向下滚动
            oldY = newY;
            if (newY<0 && scrollView.tracking == YES) {
                // 隐藏
                [UIView animateWithDuration:0.5 animations:^{
                    self.alpaView.alpha  = 0.0;
                    self.searchBar.alpha = 0.0;
                }];
            }
        }else{
            // do nothing
        }

    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
