//
//  TNBaseHTTPRequest.h
//  Demos
//
//  Created by schiller on 15/7/25.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSInteger TNHTTPRequestID;

extern NSString *const serverTypeHTTP;
extern NSString *const serverTypeDynamicHTTP;
extern NSString *const serverTypeHTTPS;
extern NSString *const serverTypeChat;
extern NSString *const serverTypeCustomerService;
extern NSString *const serverTypeJavaHTTP;
extern NSString *const serverTypeJavaHTTPS;

extern NSString *const HTTPMethodGET;
extern NSString *const HTTPMethodPOST;

typedef NS_ENUM(NSUInteger, TNCacheInterval)
{
    TNCacheIntervalNone   = 0,
    TNCacheIntervalOneDay = 24*60*60,
    TNCacheIntervalThreeDay = 3*24*60*60,
    TNCacheIntervalSevenDay = 7*24*60860
};


@interface TNBaseHTTPRequest : NSObject

@property (nonatomic, assign) TNHTTPRequestID requestID;
@property (nonatomic, copy, readonly) NSString *serverType;
@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy, readonly) NSString *HTTPMethod;
@property (nonatomic, copy) NSDictionary *params;
@property (nonatomic, assign) NSTimeInterval cacheInterval;
@property (nonatomic, copy) NSString *responseModelClassString;
@property (nonatomic, assign) BOOL *modernInterface;

+ (instancetype)requestWithPath:(NSString *)path
                         param:(NSDictionary *)params;

+ (instancetype)requestWithServerType:(NSString *)serverType
                                path:(NSString *)path
                              params:(NSDictionary *)params;

+ (instancetype)requestServerType:(NSString *)serverType
                          path:(NSString *)path
                    HTTPMethod:(NSString *)HTTPMethod
                         param:(NSDictionary *)params;

+ (instancetype)requestWithServerType:(NSString *)serverType
                          path:(NSString *)path
                    HTTPMethod:(NSString *)HTTPMethod
                         param:(NSDictionary *)params
                  timeInterval:(NSTimeInterval)timeInterval;

- (NSString *)cacheFileName;

@end
