//
//  NSArray+GLStuff.m
//  Demos
//
//  Created by gaolong on 15/8/25.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "NSArray+GLStuff.h"

@implementation NSArray (GLStuff)

- (NSUInteger)indexOfMaximumElement
{
    id maxValue = [self firstObject];
    NSUInteger indexOfMaxValue = 0;
    NSUInteger count = [self count];
    for (NSUInteger i = 1; i < count ; i++) {
        id value = self[i];
        
        if ([value compare:maxValue] == NSOrderedDescending) {
            maxValue = value;
            indexOfMaxValue = i;
        }
    }
    return indexOfMaxValue;
}

- (NSArray *)indexesOfMinimumAndMaximumElements
{
    return @[];
}

- (NSString *)longestString
{
    NSString *returnValue = nil;
    for (NSString *string in self) {
        if (returnValue == nil || [string length] > [returnValue length]) {
            returnValue = string;
        }
    }
    
    return returnValue;
}

- (NSString *)shortestString
{
    NSString *returnValue = nil;
    for (NSString *string in self) {
        if (returnValue == nil || [string length] < [returnValue length]) {
            returnValue = string;
        }
    }
    
    return returnValue;
}

@end
