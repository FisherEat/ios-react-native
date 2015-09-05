//
//  NSDictionary+JSON.m
//  TuNiuApp
//
//  Created by Ben on 15/1/21.
//  Copyright (c) 2015年 Tuniu. All rights reserved.
//

#import "TNJSONStuff.h"

@implementation NSString (JSON)

- (id)tn_objectFromJSONString
{
    NSData *JSONData = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:JSONData
                                           options:0
                                             error:nil];
}

@end

@implementation NSDictionary (JSON)

- (NSString *)tn_JSONString
{
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                         error:nil];
    return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
}

@end

@implementation NSData (JSON)

- (id)tn_JSONObject
{
    return [NSJSONSerialization JSONObjectWithData:self
                                           options:0
                                             error:nil];
}

@end
