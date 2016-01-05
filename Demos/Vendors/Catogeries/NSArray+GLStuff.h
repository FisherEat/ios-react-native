//
//  NSArray+GLStuff.h
//  Demos
//
//  Created by gaolong on 15/8/25.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (GLStuff)

//获取最大元素的下标
- (NSUInteger)indexOfMaximumElement;

//获取最大、最小元素的下标
- (NSArray *)indexesOfMinimumAndMaximumElements;

//获取数组中最长字符串
- (NSString *)longestString;

//获取数组中最短字符串
- (NSString *)shortestString;

//获取两个数组的交集
- (NSArray *)intersectionWithArray:(NSArray *)secondArray;

//
@end
