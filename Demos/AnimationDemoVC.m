//
//  AnimationDemoVC.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "AnimationDemoVC.h"

#define kGGreenColor [UIColor colorWithRed:0.379 green:0.799 blue:0.444 alpha:1.000].CGColor

static float angle;
@interface AnimationDemoVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *myButton;
@property (nonatomic, strong) UITapGestureRecognizer   *tapGestureRecongnizer;/**< 轻击手势*/
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGestureRecongnizer;/**< 滑动手势*/
@property (nonatomic)         BOOL isPuase;

@end

@implementation AnimationDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isPuase = YES;
    angle   = 90;
    
    //轻按手势
    self.tapGestureRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(handleTaps)];
    self.tapGestureRecongnizer.numberOfTouchesRequired = 1;
    self.tapGestureRecongnizer.numberOfTapsRequired    = 3;
    [self.view addGestureRecognizer:self.tapGestureRecongnizer];
    
    //轻扫手势
    self.swipeGestureRecongnizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(handleSwipes)];
    self.swipeGestureRecongnizer.direction = UISwipeGestureRecognizerDirectionUp;
    self.swipeGestureRecongnizer.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:self.swipeGestureRecongnizer];
    
    [self addAnimationButton];
    
}

- (void)handleTaps
{
    [self showAnimation];
    
}

- (void)handleSwipes
{
    [self showAnimation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)addAnimationButton
{
    self.myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myButton.frame   = CGRectMake(0, 0, 100, 100);
    self.myButton.center = self.view.center;
    
    [self.myButton setTitle:@"点我" forState:UIControlStateNormal];
    [self.myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.myButton.layer.backgroundColor = kGGreenColor;
   
//    [self.myButton addTarget:self
//                      action:@selector(showAnimation)
//            forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.myButton];
    
}

#pragma mark -
#pragma mark Another API to show animation

- (void)popAnimation
{
    //POPPropertyAnimation
}

#pragma mark - 
#pragma mark move animation
- (CABasicAnimation *)moveX:(float)time X:(NSNumber *)x
{
    CABasicAnimation *animtion = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animtion.toValue  = x;
    animtion.duration = time;
    animtion.removedOnCompletion = NO;
    animtion.repeatCount = MAXFLOAT;
    animtion.fillMode = kCAFillModeForwards;
    return animtion;
}

#pragma mark -
#pragma mark rotation animation
- (CABasicAnimation *)rotationWithDuration:(float)duration degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount
{
    CATransform3D rotationTransform = CATransform3DMakeRotation(degree, 0, 0, direction);
    CABasicAnimation *animation     = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue  = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.autoreverses = NO;
    animation.cumulative   = kCAFillModeBackwards;
    animation.delegate     = self;
    
    return  animation;
}

- (void)showAnimation
{

    if(self.isPuase)
    {
        [self startTranslationAnimation];
        [self resumeButton];
        
    }
    else
    {
        [self pauseButton];
    }
    
}

/** UIView层旋转动画实现 */
- (void)startRotationAnimation
{
    [UIView beginAnimations:@"clockwiseAnimation" context:NULL];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    
    self.myButton.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.f));
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
}

/** 设置动画不停旋转 */
- (void)endAnimation
{
    angle += 10;
    [self startRotationAnimation];
}


/** UIView层平移动画实现*/

- (void)startTranslationAnimation
{
    [UIView beginAnimations:@"Translation_X_animation" context:NULL];
    [UIView setAnimationDuration:3];
    [UIView setAnimationDelegate:self];
    
    self.myButton.transform = CGAffineTransformMakeTranslation(0, -200);
    [UIView setAnimationDidStopSelector:@selector(stop)];
    [UIView commitAnimations];

}

- (void)stop
{
   //self.myButton.frame   = CGRectMake(self.view.centerX, self.view.centerY, 100, 100);
    
}

#pragma mark -
#pragma mark set animation start and stop

/** 停止layer上面的动画 */
- (void)pauseLayer:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed      = 0.0;
    layer.timeOffset = pausedTime;
    
}

/** 继续layer上面的动画 */
- (void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
    
}

- (void)pauseButton
{
    [self.myButton setTitle:@"开始" forState:UIControlStateNormal];
    [self pauseLayer:self.myButton.layer];
    self.isPuase = YES;
    
}

- (void)resumeButton
{
    [self.myButton setTitle:@"暂停" forState:UIControlStateNormal];
    [self resumeLayer:self.myButton.layer];
    self.isPuase = NO;
    
}

#pragma mark -
#pragma mark animation delegate

- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
