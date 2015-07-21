//
//  ThirdViewController.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "ThirdViewController.h"
#import "OButton.h"

@interface ThirdViewController ()

@property(nonatomic, strong) OButton  *myButton;
@property(nonatomic)         UIColor    *bColor;
@property(nonatomic, strong) UISlider *mySlider;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.bColor = [UIColor colorWithRed:0.2 green:0.3 blue:0.4 alpha:1.0];

//    [self addButton];
//    [self.myButton addTarget:self action:@selector(changeBackGroundColor) forControlEvents:UIControlEventTouchUpInside];

    [self addSlider];
 
    [self addObserver:self forKeyPath:@"bColor" options:NSKeyValueObservingOptionInitial context:nil];
    [self.mySlider addTarget:self action:@selector(changeSliderAction) forControlEvents:UIControlEventValueChanged];
//
//    [self addObserver:self forKeyPath:@"mySlider.value" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
    
    [self setValue:@(0.5) forKeyPath:@"mySlider.value"];
}

- (void)changeSliderAction
{
    self.bColor = [UIColor colorWithRed:self.mySlider.value green:self.mySlider.value blue:self.mySlider.value alpha:1];
   // NSLog(@"slider color = %@", self.bColor);
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"bColor"]) {
        
        self.view.backgroundColor = self.bColor;
        NSLog(@"background color = %@", self.bColor);
    }else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}

- (void)addSlider
{
    self.mySlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    self.mySlider.center = self.view.center;
    [self.view addSubview:self.mySlider];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.bColor removeObserver:self forKeyPath:@"bColor"];

    
}



//- (void)addButton
//{
//    self.myButton = [OButton buttonWithType:UIButtonTypeCustom];
//    self.myButton.frame    = CGRectMake(0, 150, self.view.width / 2, 50);
//    self.myButton.centerX  = self.view.centerX;
//    [self.myButton setTitle:@"Click Me!" forState:UIControlStateNormal];
//    [self.view addSubview:self.myButton];
//    
//}
// - (void)changeBackGroundColor
//{
//    self.backgroundColror = [UIColor colorWithRed:0.861 green:0.648 blue:0.703 alpha:0.990];
//    //self.view.backgroundColor = self.backgroundColror;
//     mAlert(@"提示", @"BackGroundColor Changed Succedly!", @"Cancel", @"OK");
//    NSLog(@"color changed %@", self.backgroundColror);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
