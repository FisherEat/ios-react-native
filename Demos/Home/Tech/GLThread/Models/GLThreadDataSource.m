//
//  GLThreadDataSource.m
//  Demos
//
//  Created by gaolong on 16/7/4.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLThreadDataSource.h"

@interface GLThreadDataSource ()

@end

@implementation GLThreadDataSource

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (void)runInSyncThread
{
    NSLog(@"之前--- %@", [NSThread currentThread]);
    dispatch_queue_t que = dispatch_queue_create(0, 0);
    //如果que = dispatch_get_main_queue()则会卡死
    dispatch_sync(que, ^{
        NSLog(@"sync - %@", [NSThread currentThread]);
    });
    NSLog(@"之后--- %@", [NSThread currentThread]);
}

//dispatch_sync 立即阻塞当前的主线程
+ (void)blockInSyncThread
{
    dispatch_queue_t Que = dispatch_queue_create(0, 0);
    NSLog(@"之前 - %@", [NSThread currentThread]);
    dispatch_async(Que, ^{
        NSLog(@"sync之前 - %@", [NSThread currentThread]);
        dispatch_sync(Que, ^{
            NSLog(@"sync -- ing %@", [NSThread currentThread]);
        });
        NSLog(@"sync -- 之后 %@", [NSThread currentThread]);
    });
    NSLog(@"之后 - %@", [NSThread currentThread]);
}

//队列组
+ (void)groupThreads
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"group-01 - %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 8; i++) {
            NSLog(@"group-02 - %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            NSLog(@"group-03 - %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"所有全部都完成 %@", [NSThread currentThread]);
    });
}

+ (void)syncCompile
{
    //GCD
    //需要一个全局变量queue，要让所有线程的这个操作都加到一个queue中
    __block NSInteger lastTicket;
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSInteger ticket = lastTicket;
        [NSThread sleepForTimeInterval:0.1];
        NSLog(@"%ld - %@",ticket, [NSThread currentThread]);
        ticket -= 1;
        lastTicket = ticket;
    });
}

//延迟执行
+ (void)delayComplie
{
    // 创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 设置延时，单位秒
    double delay = 3;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), queue, ^{
        // 3秒后需要执行的任务
    });
    
    //类似于NSTimer
    //[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(run:) userInfo:@"abc" repeats:NO];
    
    //单例模式， dispatch_once下线程安全，保证在多线程下也只有一个单例
//    @interface Tool : NSObject
//    + (instancetype)sharedTool;
//    @end
//    @implementation Tool
//    static id _instance;
//    + (instancetype)sharedTool {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            _instance = [[Tool alloc] init];
//        });
//        return _instance;
//    }
//    @end
    
    //从其他线程回到主线程
    //[self performSelectorOnMainThread:@selector(run) withObject:nil waitUntilDone:NO];
    
    ////Objective-C
//    dispatch_async(dispatch_get_main_queue(), ^{
//    });
    
    
}


@end
