//
//  UIViewController+Analysis.m
//  Demos
//
//  Created by schiller on 15/8/28.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "UIViewController+Analysis.h"
#import "NSObject+BlackMagic.h"
#import "Toast+UIView.h"

typedef void (*_VIMP) (id, SEL, ...);
typedef id (*_IMP) (id, SEL, ...);

@implementation UIViewController (Analysis)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self tn_swizzleInstanceSelector:@selector(viewWillAppear:) withSelector:@selector(tna_viewWillAppear:)];
        [self tn_swizzleInstanceSelector:@selector(viewDidAppear:) withSelector:@selector(tna_viewDidAppear:)];
        
        //
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        _VIMP viewDidLoad_IMP = (_VIMP)method_getImplementation(viewDidLoad);
        method_setImplementation(viewDidLoad, imp_implementationWithBlock(^(id target, SEL action) {
            viewDidLoad_IMP(target, @selector(viewDidLoad));
            NSLog(@"%@ did load", target);
        }));
        
    });
}

- (void)tna_viewWillAppear:(BOOL)animated
{
    [self tna_viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view makeToast:[NSString stringWithFormat:@"%@ -> %@",@"当前页面" ,@"下一页面"] duration:4.0f position:@"top"];
    });
}

- (void)tna_viewDidAppear:(BOOL)animated
{
    [self tna_viewDidAppear:animated];
   
}

@end
