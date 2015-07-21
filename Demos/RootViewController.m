//
//  RootViewController.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "RootViewController.h"
#import "ButtonDemoVC.h"
#import "ScrollDemoVC.h"
#import "PickerViewDemoVC.h"
#import "TarBarDemoVC.h"
#import "AnimationDemoVC.h"
#import "TNCycleScrollView.h"
#import "TNTableViewCell.h"
#import "TNHomeSpecialSaleCell.h"

@interface RootViewController ()

@end

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTable;
@property (nonatomic, strong) NSMutableArray     *demoArray;
@property (nonatomic, strong) TNCycleScrollView *adCycleScrollView;
@property (nonatomic, strong) UIPageControl     *pageControl;
@property (nonatomic, strong) NSMutableArray    *adViewsArray;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demos";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    
    
    self.myTable.delegate   = self;
    self.myTable.dataSource = self;
    [self.view addSubview:self.myTable];
    
    self.demoArray = [NSMutableArray arrayWithArray:@[@"customDemo", @"ButtonDemo", @"ScrollDemo", @"PickerViewDemo", @"TarBarDemo", @"AnimationDemo", @"shit"]];
    [self setScrollAdvertise];
    
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
    
    [self.adCycleScrollView addSubview:self.pageControl];
    __weak __typeof(&*self)weakSelf = self;
    [self.adCycleScrollView addPageChangedHandler:^(NSInteger pageNum) {
        weakSelf.pageControl.currentPage = pageNum % weakSelf.pageControl.numberOfPages;
    }];
    
    
    NSArray *imageNameArray = @[@"shui", @"shang", @"hu"];
    //添加轮转视图
        for (int i = 0; i < 3; i++) {
            UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ceil(HEADER_IMAGEVIEW_SHOW_HEIGHT))];
            [adImageView setImage:[UIImage imageNamed:@"loading_image_640x480"]];
            adImageView.contentMode   = UIViewContentModeScaleAspectFill;
            adImageView.clipsToBounds = YES;
            adImageView.userInteractionEnabled = YES;
           // adImageView.image = [imageNameArray objectAtIndex:i];
            [self.adViewsArray addObject:adImageView];
            
        }
    
    self.pageControl.numberOfPages = 3 ;//[self.adViewsArray count];
    
    self.myTable.tableHeaderView = self.adCycleScrollView;
    
    [self.adCycleScrollView reloadScrollViewData];
    self.adCycleScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex)
    {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if (!strongSelf.adViewsArray[pageIndex]) {
        }
        return strongSelf.adViewsArray[pageIndex];
        
    };
}


- (void)setAcceory
{
    
}
#pragma mark tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger height = 0;
    if (indexPath.row == 0) {
        height = 133.0f + 10.0f;
    }else
    {
        height = 50;
    }
    
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor =[UIColor colorWithRed:0.854 green:0.000 blue:0.000 alpha:0.890];
    
    switch (indexPath.row) {
            case 0:
        {
            //
        }
            break;
        case 1:
        {
            ButtonDemoVC *btnDemoVC = [[ButtonDemoVC alloc] init];
            btnDemoVC.title = [self.demoArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:btnDemoVC animated:YES];
        }
            break;
        
        case 2:
        {
            ScrollDemoVC *scrollDemoVC = [[ScrollDemoVC alloc] init];
            scrollDemoVC.title = [self.demoArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:scrollDemoVC animated:YES];
        }
            break;
        
        case 3:
        {
            PickerViewDemoVC *pickerDemoVC = [[PickerViewDemoVC alloc] init];
            pickerDemoVC.title = [self.demoArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:pickerDemoVC animated:YES];
            
        }
            break;
       
        case 4:
        {
            TarBarDemoVC *tabBarVC = [[TarBarDemoVC alloc]init];
            tabBarVC.title = [self.demoArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:tabBarVC animated:YES];

        }
            break;
        
        case 5:
        {
            AnimationDemoVC *animationVC = [[AnimationDemoVC alloc] init];
            animationVC.title = [self.demoArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:animationVC animated:YES];

        }
            break;
        default:
            break;
    }
    
}

#pragma mark tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.demoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    static NSString *indentified = @"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:indentified];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentified];
    }
    
    if (indexPath.row == 0) {
         cell = [self dequeSpecialSaleCell:self.myTable specialInfos:nil withRowIndex:indexPath.row];
    }
    
    if (indexPath.row>0) {
        cell.textLabel.text = [NSString stringWithFormat:@"Cell%ld_%@",(long)indexPath.row ,[self.demoArray objectAtIndex:indexPath.row]];
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.000 green:0.618 blue:0.000 alpha:1.000];
        
        cell.accessoryView= [self setButton];
    }

    return cell;
    
}

- (UIButton *)setButton
{
    UIButton *button ;
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor= [UIColor clearColor];
    
    UIImage *image= [UIImage imageNamed:@"diy_add"];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.backgroundColor= [UIColor clearColor];
    
    [button addTarget:self action:@selector(createNewCell) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

- (TNTableViewCell *)dequeSpecialSaleCell:(UITableView *)tableView specialInfos:(NSArray *)specialArray withRowIndex:(NSInteger)rowIndex
{
    TNHomeSpecialSaleCell *specialCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TNHomeSpecialSaleCell class])];
    if (!specialCell) {
        specialCell = [[TNHomeSpecialSaleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TNHomeSpecialSaleCell class])];
        
    }
    //  [specialCell bindSpecialInfos:<#(NSArray *)#> withIndex:<#(NSInteger)#>]
    
    return  specialCell;
    
}

- (void)createNewCell
{
    //
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
