//
//  GLActivityIndictorView.m
//  Demos
//
//  Created by gaolong on 16/2/7.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLActivityIndictorView.h"

@interface GLActivityIndictorView ()

@property (nonatomic, strong) UIImageView *animateCircle;

@end

@implementation GLActivityIndictorView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    [self addSubview:self.animateCircle];
    [self setUpConstraits];
}

- (void)setUpConstraits
{
    [self.animateCircle autoCenterInSuperview];
}

- (UIImageView *)animateCircle
{
    if (!_animateCircle) {
        _animateCircle = [UIImageView newAutoLayoutView];
        _animateCircle.image = [UIImage imageNamed:@"loading_indicator"];
    }
    return _animateCircle;
}

- (void)startAnimating
{
    self.hidden = NO;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @0;
    animation.toValue = @(2 * M_PI);
    animation.repeatCount = HUGE_VALF;
    animation.duration = 1.0f;
    [self.animateCircle.layer addAnimation:animation forKey:@"rotate"];
}

- (void)stopAnimating
{
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }
    [self.animateCircle.layer removeAllAnimations];
    
}

//- (void)willMoveToSuperview:(UIView *)newSuperview
//{
//    [super willMoveToSuperview:newSuperview];
//    [self autoSetDimensionsToSize:CGSizeMake(30.0f, 30.0f)];
//    [self autoCenterInSuperview];
//}

@end
