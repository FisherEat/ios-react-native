//
//  GLThreadDataSource.h
//  Demos
//
//  Created by gaolong on 16/7/4.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLThreadDataSource : NSObject

//同步队列阻塞主线程
+ (void)runInSyncThread;

//同步阻塞当前线程
+ (void)blockInSyncThread;

//队列组
+ (void)groupThreads;

//线程同步，互斥锁 ，参考文档url
//@synchronized(self)
// https://www.zybuluo.com/MicroCai/note/64272

//同步执行
+ (void)syncCompile;


@end
