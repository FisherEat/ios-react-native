//
//  GLRequest.m
//  Demos
//
//  Created by gaolong on 15/12/31.
//  Copyright © 2015年 schiller. All rights reserved.
//

#import "GLRequest.h"

NSString *const HTTPMethodGET = @"GET";
NSString *const HTTPMethodPOST = @"POST";

@interface GLRequest ()

@end

@implementation GLRequest 

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (instancetype)requestWithPath:(NSString *)path params:(NSDictionary *)params
{
    return [self requestWithPath:path HTTPMethod:HTTPMethodPOST params:params timeInterval:0];
}

+ (instancetype)requestWithPath:(NSString *)path HTTPMethod:(NSString *)HTTPMethod params:(NSDictionary *)params
{
    return [self requestWithPath:path HTTPMethod:HTTPMethod params:params timeInterval:0];
}

+ (instancetype)requestWithPath:(NSString *)path HTTPMethod:(NSString *)HTTPMethod params:(NSDictionary *)params timeInterval:(NSTimeInterval)timeInterval
{
    GLRequest *request = [[GLRequest alloc] init];
    request.path = path;
    request.httpMethod = HTTPMethod;
    request.params = params;
    request.cacheInterval = timeInterval;

    return request;
}

@end
