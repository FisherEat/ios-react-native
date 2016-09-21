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
    //dispatch_queue_t que = dispatch_queue_create(0, 0);
    dispatch_queue_t que = dispatch_queue_create("com.gaolong.sycronizeque", DISPATCH_QUEUE_SERIAL);
    //如果que = dispatch_get_main_queue()则会卡死
    dispatch_sync(que, ^{
        NSLog(@"sync - %@", [NSThread currentThread]);
    });
    NSLog(@"之后--- %@", [NSThread currentThread]);
}

//dispatch_sync 立即阻塞当前的主线程
/**
 *  @brief 串行队列执行异步任务，嵌套同步任务导致死锁。
 *  因为串行队列是一个一个按照顺序执行的，前一个任务完成，后面的任务才能接着开始，
 *  执行异步任务，只有等到大括号里最后完成，才算完成，此时还未完成，就执行同步任务，
 *  被同步任务抢占资源，导致死锁
 */
+ (void)blockInSyncThread
{
    //dispatch_queue_t Que = dispatch_queue_create(0, 0);
    dispatch_queue_t Que = dispatch_queue_create("syncblockque", DISPATCH_QUEUE_SERIAL);
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

/**
 *  @brief 并发队列开启异步任务嵌套同步任务？会不会阻塞呢?
     不会阻塞并发线程，但是里面会顺序执行。
    因为并发队列异步执行，会将里面的任务抛到队列里，不需要等到任务全部完成。因此不会和嵌套的同步任务竞争资源。
 */
+ (void)blockInConcurrentQueue
{
    dispatch_queue_t que = dispatch_queue_create("com.gaolong.concurrentque", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"111,i = %@, %@", @(i), [NSThread currentThread]);
        }
        dispatch_sync(que, ^{
            for (NSInteger j = 0; j < 4; j++) {
                NSLog(@"222, j = %@, %@", @(j), [NSThread currentThread]);
            }
        });
        for (NSInteger k = 0; k < 5; k++) {
            NSLog(@"333, k = %@, %@", @(k), [NSThread currentThread]);
        }
    });
}

/**
 *  @brief 同步队列执行同步执行，嵌套异步任务。不会出现死锁，因为异步任务会开启新的线程。单独执行
   前面几个都是main。而333,<NSThread: 0x7f9982748130>{number = 3, name = (null)}，333走的是新的线程。
 */
+ (void)noBlockInSyncThread
{
    dispatch_queue_t myQue = dispatch_queue_create("noblockayncque", DISPATCH_QUEUE_SERIAL);
    NSLog(@"111,%@", [NSThread currentThread]);
    dispatch_sync(myQue, ^{
        NSLog(@"222,%@", [NSThread currentThread]);
        dispatch_async(myQue, ^{
            NSLog(@"333,%@", [NSThread currentThread]);
        });
        NSLog(@"444,%@", [NSThread currentThread]);
    });
    
    NSLog(@"555，%@", [NSThread currentThread]);
}

/**
 *  @brief 串行队列中开启异步任务是有顺序的，但是嵌套异步任务后是，异步任务333是没有顺序的,最后打印发现异步333是在222和444执行完毕后才执行的，而且222、333、444在同一线程中执行。
 */
+ (void)noBlockInAyncThread
{
    dispatch_queue_t myQue = dispatch_queue_create("noBlockInSyncThread", DISPATCH_QUEUE_SERIAL);
    NSLog(@"111,%@", [NSThread currentThread]);
    dispatch_async(myQue, ^{
        NSLog(@"222 , %@", [NSThread currentThread]);
        dispatch_async(myQue, ^{
            for (NSInteger i = 0; i < 100; i++) {
                NSLog(@"333, i = %@, %@",@(i), [NSThread currentThread]);
            }
        });
        for (NSInteger j = 0; j < 100; j++) {
             NSLog(@"444, j= %@, %@", @(j),[NSThread currentThread]);
        }
    });
    
    NSLog(@"555, %@", [NSThread currentThread]);
}

/**
 *  @brief 串行队列异步执行，嵌套主队列异步执行
    主队列只有一个主线程，主队列是串行队列，不会再开线程， 其他队列会开启新的线程。
    主队列执行同步任务，必定出现死锁！因为同步任务抢占资源。
   结果：333和444交错进行，333在串行队列中不是按照顺序进行，444在主队列中顺序进行。
  333应该是按照顺序执行的。
 */
+ (void)t_mainQueue
{
    dispatch_queue_t myQue = dispatch_queue_create("noBlockInSyncThread", DISPATCH_QUEUE_SERIAL);
    NSLog(@"111,%@", [NSThread currentThread]);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"222 , %@", [NSThread currentThread]);
        dispatch_async(myQue, ^{
            for (NSInteger i = 0; i < 100; i++) {
                NSLog(@"333, i = %@, %@",@(i), [NSThread currentThread]);
            }
        });
        for (NSInteger j = 0; j < 100; j++) {
            NSLog(@"444, j= %@, %@", @(j),[NSThread currentThread]);
        }
    });
    
    NSLog(@"555, %@", [NSThread currentThread]);
}

//队列组
/**
 *  @brief 队列组可以将很多队列添加到一个组里，这样做的好处是，当这个组里所有的任务都执行完了，队列组会通过一个方法通知我们。下面是使用方法，这是一个很实用的功能。
    global队列是并发队列，所以333不按照顺序执行。
 */
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

/**
 *  @brief 串行队列中开启异步任务是有顺序的，所有 i会按照顺序打印！！！
 */
+ (void)t_asyque
{
    dispatch_queue_t que = dispatch_queue_create("com.gaolong.asyque", DISPATCH_QUEUE_SERIAL);
    dispatch_async(que, ^{
        for (NSInteger i = 0; i < 1000; i++) {
            NSLog(@"111,i=%@, %@", @(i), [NSThread currentThread]);
        }
    });
}

/**
 *  @brief 还是按照顺序执行的，因为iOS无法自定义并发队列！
 *  附：串行队列开启异步任务是有顺序的，串行队列开启同步任务是有顺序的，
        并发队列开启同步任务是有顺序的，并发队列开启异步任务是没有顺序的。
    但是iOS无法自定义并发队列！
 */
+ (void)t_concurrentAsyQue
{
    dispatch_queue_t que = dispatch_queue_create("com.gaolong.concurrent.asyque", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(que, ^{
        for (NSInteger i = 0; i < 1000; i++) {
            NSLog(@"111,i=%@, %@", @(i), [NSThread currentThread]);
        }
        for (NSInteger j =1000; j < 2000; j++) {
             NSLog(@"222,i=%@, %@", @(j), [NSThread currentThread]);
        }
    });
}

+ (void)t_concuerrent_global
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger k = 0; k<1000; k++) {
            NSLog(@"111,k = %@, %@", @(k), [NSThread currentThread]);
        }
    });
}

/**
 *  @brief 所谓线程同步就是为了防止多个线程抢夺同一个资源造成的数据安全问题，所采取的一种措施。当然也有很多实现方法，请往下看：
 互斥锁 ：给需要同步的代码块加一个互斥锁，就可以保证每次只有一个线程访问此代码块。
 @synchronized(self) {
 //需要执行的代码块
 }
 同步执行 ：我们可以使用多线程的知识，把多个线程都要执行此段代码添加到同一个串行队列，这样就实现了线程同步的概念。
 //GCD
 //需要一个全局变量queue，要让所有线程的这个操作都加到一个queue中
 dispatch_sync(queue, ^{
 NSInteger ticket = lastTicket;
 [NSThread sleepForTimeInterval:0.1];
 NSLog(@"%ld - %@",ticket, [NSThread currentThread]);
 ticket -= 1;
 lastTicket = ticket;
 });
 
 延迟执行
 所谓延迟执行就是延时一段时间再执行某段代码。下面说一些常用方法。
 
 // 3秒后自动调用self的run:方法，并且传递参数：@"abc"
 [self performSelector:@selector(run:) withObject:@"abc" afterDelay:3];

 // 创建队列
 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 // 设置延时，单位秒
 double delay = 3;
 
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), queue, ^{
 // 3秒后需要执行的任务
 });
 
 NSTimer
 
 NSTimer 是iOS中的一个计时器类，除了延迟执行还有很多用法，不过这里直说延迟执行的用法。同样只写 OC 版的，Swift 也是相同的。
 
[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(run:) userInfo:@"abc" repeats:NO];
 
 单例模式
 至于什么是单例模式，我也不多说，我只说说一般怎么实现。在 Objective-C 中，实现单例的方法已经很具体了，虽然有别的方法，但是一般都是用一个标准的方法了，下面来看看。
 
 @interface Tool : NSObject <NSCopying>
 
 + (instancetype)sharedTool;
 
 @end
 
 @implementation Tool
 
 static id _instance;
 
 + (instancetype)sharedTool {
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 _instance = [[Tool alloc] init];
 });
 
 return _instance;
 }
 
 @end
 
 从其他线程回到主线程的方法
 我们都知道在其他线程操作完成后必须到主线程更新UI。所以，介绍完所有的多线程方案后，我们来看看有哪些方法可以回到主线程。
 
 //Objective-C
 dispatch_async(dispatch_get_main_queue(), ^{
 
 });
 */

/**
 *  @brief 下面是一个关于在 dispatch_async 上如何以及何时使用不同的队列类型的快速指导：
 
1. 自定义串行队列：当你想串行执行后台任务并追踪它时就是一个好选择。这消除了资源争用，因为你知道一次只有一个任务在执行。注意若你需要来自某个方法的数据，你必须内联另一个 Block 来找回它或考虑使用 dispatch_sync。
2. 主队列（串行）：这是在一个并发队列上完成任务后更新 UI 的共同选择。要这样做，你将在一个 Block 内部编写另一个 Block 。以及，如果你在主队列调用 dispatch_async 到主队列，你能确保这个新任务将在当前方法完成后的某个时间执行。
3. 并发队列：这是在后台执行非 UI 工作的共同选择。
 */
@end
