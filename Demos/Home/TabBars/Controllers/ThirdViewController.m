//
//  ThirdViewController.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "ThirdViewController.h"
#import "OButton.h"
#import "PassMesg.h"
#import "TestNet101ViewController.h"
#import "GLTrainScrollBarView.h"

static NSString *const KVO_CONTEXT_ADDRESS_CHANGED = @"KVO_CONTEXT_ADDRESS_CHANGED" ;
static const CGFloat topToolBarHeight = 40.0f;

@interface ThirdViewController ()<UIGestureRecognizerDelegate,GLTopBarViewDelegate>

@property(nonatomic, strong) OButton  *myButton;
@property(nonatomic)         UIColor    *bColor;
@property(nonatomic, strong) UISlider *mySlider;
@property(nonatomic, strong) PassMesg *aPerson;
@property(nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) GLTrainScrollBarView *trainScrollbar;
@property (nonatomic ,strong) NSMutableArray *trainListArray;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.bColor = [UIColor colorWithRed:0.216 green:0.800 blue:0.406 alpha:1.000];

    [self addButton];
    [self addSlider];
    [self addPerson];
    
    //每次只能给一个对象设置一个观察者，否则会出错
    //[self addObserver:self forKeyPath:@"bColor" options:NSKeyValueObservingOptionInitial context:nil];
    [self addObserver:self forKeyPath:@"aPerson.name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:(void *)KVO_CONTEXT_ADDRESS_CHANGED];
    
    [self.aPerson setValue:@"xiaobao" forKey:@"name"];

    [self myBlock];
 //   [self setWebView];
    
    [self loadData];
    
    [self setTopBarView];
 
    self.trainListArray = [NSMutableArray arrayWithArray:@[@"单程", @"往返"]];
    [self setUpScrollBarView];
    
}

#pragma mark - UI
- (void)setUpScrollBarView
{
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = topToolBarHeight;
    self.trainScrollbar = [[GLTrainScrollBarView alloc] initWithFrame:CGRectMake(0, self.topBarView.height, width, height)];
       __weak __typeof(&*self)weakSelf = self;
    NSArray *infoArray = @[@{@"name" :@"单程", @"selected" :@(YES)},@{@"name" :@"返程", @"selected" :@(NO)}, @{@"name" :@"双程", @"selected" :@(NO)}];
    [self.trainScrollbar updateWithTrainTicketInfoArray:infoArray];
    self.trainScrollbar.switchedBlock = ^(NSInteger selectedIndex)
    {
        __strong __typeof(&*weakSelf) strongSelf = weakSelf;
        [strongSelf.trainListArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx == selectedIndex) {
                //
            }
        }];
    };
    
    [self.view addSubview:self.trainScrollbar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)setTopBarView
{
    self.topBarView.topBarStytle = GLTopBarStyleTitleLeftButtonRightButton;
    self.topBarView.titleText = @"网络相关";
    self.topBarView.rightButtonTitle = @"更多";
    
}

- (void)topBarRightButtonPressed:(UIButton *)button
{
    TestNet101ViewController *netView = [[TestNet101ViewController alloc] init];
    [self.navigationController pushViewController:netView animated:YES];
}

#pragma mark block test
- (void)getSliderValue:(sliderBlock)sliderBlock
{
   __block NSNumber *sliderValue = @0;
    if (sliderBlock) {
       sliderValue = @(self.mySlider.value);
    }
    else
    {
        NSLog(@"The block is nil");
    }
    
}

- (void)testBlock:(aBlock)changeNumberBlock
{
    NSString *test = @"It is a block";
    NSUInteger num = 12;
    NSString *blockString = @"";
    if (changeNumberBlock) {
         blockString = changeNumberBlock(test, num);
    }
    
}

- (void)loadData
{
   __block NSString *logString = @"";
  [self testBlock:^NSString *(NSString *str, NSUInteger num) {
        logString = str;
       return logString;
    }];
    
    NSLog(@"一堆狗屎%@", logString);
    
}
 - (void)setWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 100)];
    self.webView.backgroundColor = [UIColor colorWithRed:0.000 green:0.512 blue:0.000 alpha:1.000];
    UIPinchGestureRecognizer *swipeGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(detailSwipeFromLeft)];
    swipeGesture.delegate = self;
    [self.webView addGestureRecognizer:swipeGesture];
    [self.view addSubview:self.webView];
}

- (void)detailSwipeFromLeft
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark test block 
- (void)myBlock
{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:@"One", @"Two", @"Three", nil];
    int result = ^(int a)
    {
        [mutableArray removeLastObject];
        return a * a;
    }(5);
    NSLog(@"test array : %@, %@", mutableArray, @(result));
    
}

#pragma mark - person
/** change the value of Person*/
- (void)addPerson
{
    self.aPerson = [[PassMesg alloc] init];
    self.aPerson.name = @"gaolong";
    //[self.aPerson changeName:self.aPerson withName:@"ga"];
    [self.aPerson.observerArray addObject:self.aPerson];
    
}

#pragma mark - main method
/** KVO - when the value of the observer changed, this method will detect the changes from the keyPath */
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"aPerson.name"]) {
        
        NSString *name = [self.aPerson valueForKey:@"name"];
        NSLog(@"%@, has a new name.", name);
    }else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}

#pragma mark - slider
/** KVO - slide the slider to change the view backgroudcolor */
- (void)addSlider
{
    //首先通过 KVC 设置slider的初始值 ，KVC 设置值和取出值
//  [self setValue:@(0.5) forKeyPath:@"mySlider.value"];
    NSString *value = [self.mySlider valueForKeyPath:@"mySlider.value"];
    NSLog(@"%@", value);
    self.mySlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    self.mySlider.center = self.view.center;
    [self.mySlider addTarget:self action:@selector(changeSliderAction) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.mySlider];
    
}

- (void)changeSliderAction
{
    self.bColor = [UIColor colorWithRed:self.mySlider.value green:self.mySlider.value blue:self.mySlider.value alpha:1];
    // NSLog(@"slider color = %@", self.bColor);
    
}

#pragma mark - button
/**  KVO - click button to change the view backgroundcolor*/
- (void)addButton
{
    self.myButton = [OButton buttonWithType:UIButtonTypeCustom];
    self.myButton.frame    = CGRectMake(0, 150, self.view.width / 2, 50);
    self.myButton.centerX  = self.view.centerX;
    [self.myButton setTitle:@"Click Me!" forState:UIControlStateNormal];
   // [self.myButton addTarget:self action:@selector(changeBackGroundColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myButton];
    
}

 - (void)changeBackGroundColor
{
    self.bColor = [UIColor colorWithRed:0.861 green:0.648 blue:0.703 alpha:0.990];
     mAlert(@"提示", @"BackGroundColor Changed Succedly!", @"Cancel", @"OK");
    NSLog(@"color changed %@", self.bColor);
    
}

#pragma mark - dealloc
/** dealloc the observer*/
- (void)dealloc
{
    for (PassMesg *person in self.aPerson.observerArray) {
        [person removeObserver:self forKeyPath:@"name"];
    }
    self.aPerson.observerArray = nil;
    
    [self.bColor removeObserver:self forKeyPath:@"bColor"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
