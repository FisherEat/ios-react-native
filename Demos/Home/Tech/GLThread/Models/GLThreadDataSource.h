//
//  GLThreadDataSource.h
//  Demos
//
//  Created by gaolong on 16/7/4.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLThreadDataSource : NSObject

/**
 *  @brief //同步队列阻塞主线程
 */
+ (void)runInSyncThread;

/**
 *  @brief 异步串行队列嵌套同步任务 ，//同步阻塞当前线程
 */
+ (void)blockInSyncThread;

/**
 *  @brief 串行队列同步执行，嵌套异步任务
 */
+ (void)noBlockInSyncThread;

+ (void)blockInConcurrentQueue;
/**
 *  @brief 串行队列异步执行，嵌套异步任务
 */
+ (void)noBlockInAyncThread;

+ (void)t_mainQueue;

+ (void)t_asyque;

+ (void)t_concurrentAsyQue;

+ (void)t_concuerrent_global;
/**
 *  @brief //队列组
 */
+ (void)groupThreads;

//线程同步，互斥锁 ，参考文档url
//@synchronized(self)
// https://www.zybuluo.com/MicroCai/note/64272

/**
 *  @brief //同步执行
 */
+ (void)syncCompile;


@end
