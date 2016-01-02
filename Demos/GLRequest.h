//
//  GLRequest.h
//  Demos
//
//  Created by gaolong on 15/12/31.
//  Copyright © 2015年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLRequest : NSObject

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *serverType;
@property (nonatomic, copy) NSString *httpMethod;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, assign) NSTimeInterval cacheInterval;

+ (instancetype)requestWithPath:(NSString *)path HTTPMethod:(NSString *)HTTPMethod params:(NSDictionary *)params;

+ (instancetype)requestWithPath:(NSString *)path  params:(NSDictionary *)params;

+ (instancetype)requestWithPath:(NSString *)path HTTPMethod:(NSString *)HTTPMethod params:(NSDictionary *)params timeInterval:(NSTimeInterval)timeInterval;

@end
