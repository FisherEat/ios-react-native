//
//  NSTimer+Addition.h
//  TuNiuApp
//
//  Created by zhaofeng on 14-6-4.
//  Copyright (c) 2014年 Tuniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
