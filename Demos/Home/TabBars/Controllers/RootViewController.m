//
//  RootViewController.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "RootViewController.h"
#import "TarBarDemoVC.h"
#import "TNCycleScrollView.h"
#import "TNHomeSpecialSaleCell.h"
#import "LGAlertView.h"
#import "GLNetWorkDemo.h"

#import "UIRootHeaderTableViewCell.h"
#import "GLRootHomeDatas.h"
#import "UIRootBaseTableViewCell.h"

#import <objc/runtime.h>

static NSString *const defaultCellIdentifer = @"defaultCellIdentifer";

@interface RootViewController ()

@end

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource, GLRootSingleViewCellDelegate>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) UIRefreshControl  *refreshTable;
@property (nonatomic, strong) NSMutableArray    *demoArray;
@property (nonatomic, strong) TNCycleScrollView *adCycleScrollView;
@property (nonatomic, strong) UIPageControl     *pageControl;
@property (nonatomic, strong) NSMutableArray    *adViewsArray;

@property (nonatomic, strong) NSDictionary *cellClassNameDic;
@property (nonatomic, strong) NSMutableDictionary *dataSourceDic;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUpTableView];
    [self initDataSource];
    
    [self setScrollAdvertise];
    
    [self addrefreshTable];
}

#pragma mark - UI Events
- (void)setUpTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    [self.view addSubview:self.tableView];
}

- (void)initDataSource
{
    self.cellClassNameDic = @{@(GLRootHomeCellTypeHeader) :@"TNHomeSpecialSaleCell",
          @(GLRootHomeCellTypeSingle) :@"GLRootHomeSingleViewCell",
          @(GLRootHomeCellTypeButton) :@"GLRootHomeSingleViewCell"};
    self.dataSourceDic = [GLRootHomeData getCellDataSource];
}

- (GLRootHomeCellModel *)dataSourceItemAtSection:(NSInteger)section row:(NSInteger)row
{
    NSArray *sectionData = self.dataSourceDic[@(section)];
    
    return sectionData[row];
}

- (void)addrefreshTable
{
    self.refreshTable = [[UIRefreshControl alloc] init];
    self.refreshTable.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    self.refreshTable.tintColor = [UIColor greenColor];
    [self.refreshTable addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshTable];
}

- (void)pullToRefresh
{
    //模拟网络访问
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.refreshTable.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中"];
    CGFloat delayInSecond = 2.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSecond) * NSEC_PER_MSEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.refreshTable endRefreshing];
        self.refreshTable.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    });
}

#pragma mark pass value delegate
- (void)passValueByDelegate:(NSString *)delegate
{
   
}

#pragma mark 设置顶部轮播广告栏

- (void)setScrollAdvertise
{
    self.adCycleScrollView = [[TNCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADER_IMAGEVIEW_SHOW_HEIGHT - 60) animationDuration:3.0f];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50) / 2, HEADER_IMAGEVIEW_SHOW_HEIGHT - 90, 50, 40)];
    self.pageControl.userInteractionEnabled = NO;
    
    if ([self.pageControl respondsToSelector:@selector(setPageIndicatorTintColor:)])
    {
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        
    }

    __weak __typeof(&*self)weakSelf = self;
    [self.adCycleScrollView addPageChangedHandler:^(NSInteger pageNum) {
        weakSelf.pageControl.currentPage = pageNum % weakSelf.pageControl.numberOfPages;
    }];
    
    NSArray *imageNameArray = @[@"xianlu.png", @"hu.png",@"shui.png"];
    self.adViewsArray = @[].mutableCopy;
    //添加轮转视图
        for (int i = 0; i < 3; i++) {
            UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ceil(HEADER_IMAGEVIEW_SHOW_HEIGHT - 60))];
            adImageView.contentMode   = UIViewContentModeScaleAspectFill;
            adImageView.clipsToBounds = YES;
            adImageView.userInteractionEnabled = YES;
            [adImageView setImage:[UIImage imageNamed:[imageNameArray objectAtIndex:i]]];
            [self.adViewsArray addObject:adImageView];
            
        }
    
    self.pageControl.numberOfPages = 3 ;//[self.adViewsArray count];
    [self.adCycleScrollView reloadScrollViewData];
    self.adCycleScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex)
    {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if (!strongSelf.adViewsArray[pageIndex]) {
        }
        return strongSelf.adViewsArray[pageIndex];
        
    };
    
    //必须计算totalPagesCount ，否则出现bug
    self.adCycleScrollView.totalPagesCount = ^NSInteger(void){
        __strong typeof(&*weakSelf)strongSelf = weakSelf;
        return [strongSelf.adViewsArray count];
    };
    
    //TODO
    self.adCycleScrollView.TapActionBlock = ^(NSInteger pageIndex){
    };
    
    self.tableView.tableHeaderView = self.adCycleScrollView;
    [self.adCycleScrollView addSubview:self.pageControl];

}

- (void)addViewTapped:(NSInteger)adIndex
{
  //  [self gotoWebView:]
}

- (void)goToWebView:(NSString *)url title:(NSString *)title
{
    
}

#pragma mark tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  GLRootHomeCellModel *model = self.dataSourceDic[@(indexPath.section)][indexPath.row];
  return model.cellHeight;
}

#pragma mark tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataSourceDic[@(section)];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    GLRootHomeCellModel *item = [self dataSourceItemAtSection:indexPath.section row:indexPath.row];
    if (!item) {
        cell = [tableView dequeueReusableCellWithIdentifier:defaultCellIdentifer];
    }else {
        NSString *cellClassName = self.cellClassNameDic[@(item.cellType)];
        if (cellClassName) {
            UIRootBaseTableViewCell *baseCell = [UIRootBaseTableViewCell cellForTableView:tableView withIdentifier:cellClassName cellType:item.cellType];
            [baseCell bindModel:item.model];
            if ([baseCell isKindOfClass:[GLRootHomeSingleViewCell class]]) {
                GLRootHomeSingleViewCell *singleCell = (GLRootHomeSingleViewCell *)baseCell;
                singleCell.delegate = self;
            }
            cell = baseCell;
        }else {
            cell = [tableView dequeueReusableCellWithIdentifier:defaultCellIdentifer];
        }
    }
    return cell;
}

#pragma mark - GLRootSingleViewCellDelegate
- (void)singleCellDidClicked:(GLRootSingelCellModel *)cellModel
{
    if (![cellModel.toUrlString isEqualToString:@"defualtURL"]) {
        [[GLNavigator navigator] to:cellModel.toUrlString];
    }else {
        if (cellModel.cellId == LGALerViewDemoCell) {
            LGAlertView *alertView = [[LGAlertView alloc] initWithProgressViewStyleWithTitle:@"进度条" message:@"正在加载中" progressLabelText:@"进度条" buttonTitles:@[@"OK"] cancelButtonTitle:@"取消" destructiveButtonTitle:@"停止加载"];
            [alertView showAnimated:YES completionHandler:nil];
        }else if (cellModel.cellId == NetWorkDemoCell) {
            //通过纯代码向storyboard 跳转，一定要设置storyboardName、storyboard Class ,storyboard ID 三个重要属性。
            UIStoryboard *netWorkStoryBoard = [UIStoryboard storyboardWithName:@"GLNetWorkDemo" bundle:[NSBundle mainBundle]];
            GLNetWorkDemo *netWorkDemoVC    = (GLNetWorkDemo *)[netWorkStoryBoard instantiateViewControllerWithIdentifier:@"GLNetWorkDemo"];
            [self.navigationController pushViewController:netWorkDemoVC animated:YES];

        }else {
            
        }
    }
}

#pragma mark PassTextDelegate

- (NSString *)passValues:(NSString *)values
{
    NSString *msg = [NSString stringWithFormat:@"Text From ButtonDemoVC :%@", values];
    NSLog(@"from root view %@", values);
    mAlert(@"提示", msg, @"Cancel", @"OK");
    
    return msg;
}

- (void)report
{
    
}

@end
