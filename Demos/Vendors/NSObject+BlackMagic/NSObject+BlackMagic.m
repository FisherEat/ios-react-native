//
//  NSObject+BlackMagic.m
//  TuNiuApp
//
//  Created by Ben on 15/8/21.
//  Copyright (c) 2015年 Tuniu. All rights reserved.
//

#import "NSObject+BlackMagic.h"
#import <objc/runtime.h>

@implementation NSObject (BlackMagic)

+ (void)tn_swizzleInstanceSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector
{
    Class cls = [self class];
    
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod)
    {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
