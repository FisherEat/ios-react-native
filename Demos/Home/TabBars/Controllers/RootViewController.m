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
#import "TestDemoVC.h"
#import "LGAlertView.h"
#import "GLNetWorkDemo.h"
#import "PassValueBlockVC.h"
#import "TextViewController.h"
#import "AdScrollTimerViewController.h"
#import "LoginDemoVC.h"
#import "WebViewDemo.h"
#import "GLPresentViewController.h"
#import "TableViewDemoViewController.h"

@interface RootViewController ()

@end

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource, PassMesageDelegate ,PassValueDelegate>

@property (nonatomic, strong) UITableView       *myTable;
@property (nonatomic, strong) UIRefreshControl  *refreshTable;
@property (nonatomic, strong) NSMutableArray    *demoArray;
@property (nonatomic, strong) TNCycleScrollView *adCycleScrollView;
@property (nonatomic, strong) UIPageControl     *pageControl;
@property (nonatomic, strong) NSMutableArray    *adViewsArray;
@property (nonatomic, strong) ButtonDemoVC      *btnVC;

@property (nonatomic, strong) PassValueBlockVC  *passValueVC;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demos";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTable.delegate   = self;
    self.myTable.dataSource = self;
    self.myTable.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    self.btnVC = [[ButtonDemoVC alloc] init];
    //self.btnVC.delegate = self;
    
    [self.view addSubview:self.myTable];
    
    self.demoArray = [NSMutableArray arrayWithArray:@[@"customDemo", @"ButtonDemo", @"ScrollDemo", @"PickerViewDemo", @"TarBarDemo", @"AnimationDemo", @"TestDemo", @"LGALerViewDemo", @"NetWorkDemo", @"PassValueBlock", @"TextViewDemo", @"AdScrollTimerDemo", @"LoginDemo", @"WebViewDemo", @"TopBarViewDemo", @"TableViewTypesDemo"]];
    [self setScrollAdvertise];
 
    //test nil NULL
    [self test];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCalendarMsgSuccess:) name:@"SelectCalendarFromView" object:nil];
    
    [self addrefreshTable];
    
    NSUInteger isZero = 0;
    NSLog(@"%ld", isZero);
    
    NSDictionary *dict = @{};
    dict = @{@"1":@"China",@"2":@"UK",};
    NSLog(@"dictionary is = %@", dict);
    
    
    
    NSArray *arr_a = @[@(1), @(5), @(7), @(11)];
    NSMutableArray *a = [NSMutableArray arrayWithArray:arr_a];
    NSArray *arr_b = @[@(3), @(4), @(8), @(19), @(56)];
    NSMutableArray *b = [NSMutableArray arrayWithArray:arr_b];
    
    if (a.count < b.count) {
      //  [self combine:a andArray:b];
    }else {
       // [self combine:b andArray:a];
    }
    
}

#pragma mark - UI Events
- (void)addrefreshTable
{
    self.refreshTable = [[UIRefreshControl alloc] init];
    self.refreshTable.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    self.refreshTable.tintColor = [UIColor greenColor];
    [self.refreshTable addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    [self.myTable addSubview:self.refreshTable];
}

- (void)pullToRefresh
{
    //模拟网络访问
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.refreshTable.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中"];
    CGFloat delayInSecond = 2.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSecond) * NSEC_PER_MSEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [self.myTable reloadData];
        [self.refreshTable endRefreshing];
        self.refreshTable.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    });
}

#pragma mark pass value delegate
- (void)passValueByDelegate:(NSString *)delegate
{
    NSLog(@"呵呵哒。The value from pass value block = %@", delegate);
    
}

- (void)getCalendarMsgSuccess:(NSNotification *)aNotification
{
   
   NSString *str = [aNotification object];
    NSLog(@"打印日期为: %@", str);
    
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
           // [adImageView setImage:[UIImage imageNamed:@"loading_image_640x480"]];
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
    
    self.myTable.tableHeaderView = self.adCycleScrollView;
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
    switch (indexPath.row) {
            case CustomDemoCell:
        {
            //
        }
            break;
        case ButtonDemoCell:
        {
            ButtonDemoVC *btnDemoVC = [[ButtonDemoVC alloc] init];
            btnDemoVC.title = [self.demoArray objectAtIndex:indexPath.row];
            
            //把delegate的属性在这里设置，奇迹般出现了能够传值。利用委托传值之必需指定delegate的代理方，必需在特定位置指定方能生效。
            //类似 block传值，需要指定传值方。
            
            btnDemoVC.delegate = self;
            
            //用block传过来的值
            btnDemoVC.passMsgBlock = ^(NSString *str)
            {
                
                mAlert(@"Block传值", str, @"Cancel", @"OK");
                
            };
            //这个导航栏指定了接收值的一方为当前视图的对象。
            [self.navigationController pushViewController:btnDemoVC animated:YES];
        }
            break;
        
        case ScrollDemoCell:
        {
            ScrollDemoVC *scrollDemoVC = [[ScrollDemoVC alloc] init];
            scrollDemoVC.title = [self.demoArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:scrollDemoVC animated:YES];
        }
            break;
        
        case PickerViewDemoCell:
        {
            PickerViewDemoVC *pickerDemoVC = [[PickerViewDemoVC alloc] init];
            pickerDemoVC.title = [self.demoArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:pickerDemoVC animated:YES];
            
        }
            break;
       
        case TarBarDemoCell:
        {
            TarBarDemoVC *tabBarVC = [[TarBarDemoVC alloc]init];
            tabBarVC.title = [self.demoArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:tabBarVC animated:YES];

        }
            break;
        
        case AnimationDemoCell:
        {
            AnimationDemoVC *animationVC = [[AnimationDemoVC alloc] init];
            animationVC.title = [self.demoArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:animationVC animated:YES];

        }
            break;
        
        case TestDemoCell:
        {
            TestDemoVC *testDemoVC = [[TestDemoVC alloc] init];
            testDemoVC.title = [self.demoArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:testDemoVC animated:NO];
            
        }
            break;
        case LGALerViewDemoCell:
        {
            LGAlertView *alertView = [[LGAlertView alloc] initWithProgressViewStyleWithTitle:@"进度条" message:@"正在加载中" progressLabelText:@"进度条" buttonTitles:@[@"OK"] cancelButtonTitle:@"取消" destructiveButtonTitle:@"停止加载"];
            [alertView showAnimated:YES completionHandler:nil];
        }
            break;
        case NetWorkDemoCell:
        {
            //通过纯代码向storyboard 跳转，一定要设置storyboardName、storyboard Class ,storyboard ID 三个重要属性。
            UIStoryboard *netWorkStoryBoard = [UIStoryboard storyboardWithName:@"GLNetWorkDemo" bundle:[NSBundle mainBundle]];
            GLNetWorkDemo *netWorkDemoVC    = (GLNetWorkDemo *)[netWorkStoryBoard instantiateViewControllerWithIdentifier:@"GLNetWorkDemo"];
            [self.navigationController pushViewController:netWorkDemoVC animated:YES];
           
        }
            break;
        case PassValueDemoCell:
        {
            //从此处进入的PassValueBlock页面，所以  passValueVC.delegate = self;
            //所以 viewdidload 中的设定delegate指向没有作用。
            PassValueBlockVC *passValueVC = [[PassValueBlockVC alloc] init];
            passValueVC.delegate = self;
            [self.navigationController pushViewController:passValueVC animated:YES];
        }
            break;
        case TextViewDemoCell:
        {
            TextViewController *textViewVC = [[TextViewController alloc] init];
            [self.navigationController pushViewController:textViewVC animated:YES];
        }
            break;
            
        case AdScrollTimerCell:
        {
            AdScrollTimerViewController *adVC = [[AdScrollTimerViewController alloc] init];
            [self.navigationController pushViewController:adVC animated:YES];
        }
            break;
            
        case LoginDemoCell:
        {
            LoginDemoVC *loginVC = [[LoginDemoVC alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
            break;
        case WebViewDemoCell:
        {
            WebViewDemo *webViewVC = [[WebViewDemo alloc] init];
            [self.navigationController pushViewController:webViewVC animated:YES];
        }
            break;
        case TopBarViewDemoCell:
        {
            GLPresentViewController *presentVC = [[GLPresentViewController alloc] init];
            [self.navigationController pushViewController:presentVC animated:YES];
        }
            break;
        case TableViewDemoCell:
        {
            TableViewDemoViewController *tableVC = [[TableViewDemoViewController alloc] init];
            [self.navigationController pushViewController:tableVC animated:YES];
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
    
    if (indexPath.row == 0)
    {
         cell = [self dequeSpecialSaleCell:self.myTable specialInfos:nil withRowIndex:indexPath.row];
    }
    
    //利用委托传值之必需指定delegate的代理方，必需在特定位置指定方能生效。
    if (indexPath.row == 1)
    {
        cell.detailTextLabel.text = [self.btnVC.delegate passValues:@"o"];
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }

    
    if (indexPath.row > 0)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"Cell%ld_%@",(long)indexPath.row ,[self.demoArray objectAtIndex:indexPath.row]];
       //cell.contentView.backgroundColor = [UIColor colorWithRed:0.000 green:0.618 blue:0.000 alpha:1.000];
            // cell.accessoryView= [self setButton];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.586 green:0.134 blue:0.668 alpha:0.700];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
    }

    return cell;
    
}

- (UIButton *)setButton
{
    UIButton *button ;
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor= [UIColor clearColor];
    
    UIImage *image= [UIImage imageNamed:@"diy_add"];
    button        = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame  = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    button.frame  = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    button.backgroundColor= [UIColor clearColor];
    
    [button addTarget:self action:@selector(createNewCell) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

- (TNTableViewCell *)dequeSpecialSaleCell:(UITableView *)tableView specialInfos:(NSArray *)specialArray withRowIndex:(NSInteger)rowIndex
{
    TNHomeSpecialSaleCell *specialCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TNHomeSpecialSaleCell class])];
    if (!specialCell)
    {
        specialCell = [[TNHomeSpecialSaleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TNHomeSpecialSaleCell class])];
        
    }
    
    return  specialCell;
    
}

- (void)createNewCell
{
    //
}

#pragma mark - 
#pragma mark PassTextDelegate

- (NSString *)passValues:(NSString *)values
{
    NSString *msg = [NSString stringWithFormat:@"Text From ButtonDemoVC :%@", values];
    NSLog(@"from root view %@", values);
    mAlert(@"提示", msg, @"Cancel", @"OK");
    
    return msg;
    
}

#pragma mark some test
/**测试 nil \null \ NULL的区别*/
- (void)test
{
    //nil 定义某一实例对象为空 nil 解释为 NO，可以用 ！判断
    //Nil 定义某一类为空
    //NULL 定义基本数据对象为空，如(void *) ,用于C语言各种数据类型的指针为空
    //NSNull 集合对象无法包含 nil 作为其具体值，如NSArray、NSSet和NSDictionary。
    //相应地，nil 值用一个特定的对象 NSNull 来表示。NSNull 提供了一个单一实例用于表示对象属性中的的nil值。
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    mutableDict[@"aKey"] = [NSNull null];
    NSLog(@"aKey's value: %@", [mutableDict valueForKey:@"aKey"]);
    //    int  *p = NULL;
    //    char *r = NULL;
    //    " == " 是全等号
    NSObject *obj = [[NSObject alloc] init];
    //obj = nil;
    if (obj == nil) {
        NSLog(@"obj is nil");
    }else
    {
        NSLog(@"obj is not nil ");
    }
    
    //    Class someClass = Nil;
    //    Class anotherClass = [NSString class];
    
    //几个有趣的例子
    NSObject *obj1 = [[NSObject alloc] init];
    NSObject *obj2 = [NSNull null];
    NSObject *obj3 = [NSObject new];
    NSObject *ojb4;
    NSArray  *arr1 = [NSArray arrayWithObjects:obj1, obj2, obj3, ojb4, nil];
    NSLog(@"array  count = %lu", [arr1 count]);
    
    NSObject *obj8 ;
    NSObject *obj5 = [[NSObject alloc] init];
    NSObject *obj6 = [NSNull null];
    NSObject *obj7 = [NSObject new];
    NSArray  *arr2 = [NSArray arrayWithObjects:obj8, obj5, obj6 ,obj7, nil];
    NSLog(@"array count = %lu", [arr2 count]);
    
}

#pragma mark - Data Struct Practice

- (void)initTwoArray
{
    
}

- (void)combine:(NSMutableArray *)arr_a andArray:(NSMutableArray *)arr_b
{
   [arr_a enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop){
       for (NSInteger i = 0; i < arr_b.count; i ++) {
           if ([obj1 integerValue] >= [arr_b[i] integerValue]) {
               [arr_b insertObject:obj1 atIndex:i];
           }
       }
   }];
   [arr_a enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"arr_a = %ld", [obj integerValue]);
   }];
}

@end
