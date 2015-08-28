//
//  NSObject+BlackMagic.h
//  TuNiuApp
//
//  Created by Ben on 15/8/21.
//  Copyright (c) 2015年 Tuniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BlackMagic)

+ (void)tn_swizzleInstanceSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector;

@end
