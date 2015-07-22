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

static NSString *const KVO_CONTEXT_ADDRESS_CHANGED = @"KVO_CONTEXT_ADDRESS_CHANGED" ;

@interface ThirdViewController ()

@property(nonatomic, strong) OButton  *myButton;
@property(nonatomic)         UIColor    *bColor;
@property(nonatomic, strong) UISlider *mySlider;

@property(nonatomic, strong) PassMesg *aPerson;

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
    [self.myButton addTarget:self action:@selector(changeBackGroundColor) forControlEvents:UIControlEventTouchUpInside];
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
