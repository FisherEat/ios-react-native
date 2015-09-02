//
//  TNBaseHTTPRequest.h
//  Demos
//
//  Created by schiller on 15/7/25.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSInteger TNHTTPRequestID;

FOUNDATION_EXPORT NSString *const serverTypeHTTP;
FOUNDATION_EXPORT NSString *const serverTypeDynamicHTTP;
FOUNDATION_EXPORT NSString *const serverTypeHTTPS;
FOUNDATION_EXPORT NSString *const serverTypeChat;
FOUNDATION_EXPORT NSString *const serverTypeCustomerService;
FOUNDATION_EXPORT NSString *const serverTypeJavaHTTP;
FOUNDATION_EXPORT NSString *const serverTypeJavaHTTPS;
FOUNDATION_EXPORT NSString *const serverTypeStatHTTP;

FOUNDATION_EXPORT NSString *const HTTPMethodGET;
FOUNDATION_EXPORT NSString *const HTTPMethodPOST;


typedef NS_ENUM(NSUInteger, TNCacheInterval)
{
    TNCacheIntervalNone = 0,
    TNCacheIntervalOneDay = 24*60*60,
    TNCacheIntervalThreeDay = 3*24*60*60,
    TNCacheIntervalSevenDay = 7*24*60*60
};

@interface TNBaseHTTPRequest : NSObject

@property (nonatomic, assign) TNHTTPRequestID requestID;
@property (nonatomic, copy) NSString *baseURL;
@property (nonatomic, readonly, getter=isRestful) BOOL resetful;
@property (nonatomic, copy, readonly) NSString *serverType;
@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy, readonly) NSString *HTTPMethod;
@property (nonatomic, copy) NSDictionary *params;
@property (nonatomic, assign) NSTimeInterval cacheInterval;
@property (nonatomic, copy) NSString *responseModelClassString;
@property (nonatomic, assign) BOOL modernInterface; // Set to YES will not encode params to base64, thanks to stupid server developer

/**
 *  Get name of the cache file, subclass override to custom cache file name
 *
 *  @return Cache file name
 */
- (NSString *)cacheFileName;

/**
 *  A lite method of `requestWithPath:HTTPMethod:params:timeInterval:`.
 *  `HTTPMethod` = `HTTPMethodGET`, `cacheTimeInterval` = `TNCacheIntervalNone`
 *
 *  @param path   Request path, can not be nil
 *  @param params Request params
 *
 *  @return A request object
 */
+ (instancetype)requestWithPath:(NSString *)path
                         params:(NSDictionary *)params;


/**
 *  A lite method of `requestWithPath:HTTPMethod:params:timeInterval:`.
 *  `cacheTimeInterval` = `TNCacheIntervalNone`
 *
 *  @param path       Request path, can not be nil
 *  @param HTTPMethod HTTP request method, 'GET', 'POST' etc.
 *  @param params     Request params
 *
 *  @return A request object
 */
+ (instancetype)requestWithPath:(NSString *)path
                     HTTPMethod:(NSString *)HTTPMethod
                         params:(NSDictionary *)params;

/**
 *  Factory method, build a reuqest object
 *
 *  @param path         Request path, can not be nil
 *  @param HTTPMethod   HTTP request method, 'GET', 'POST' etc.
 *  @param params       Request params
 *  @param timeInterval Cache time interval, in seconds
 *
 *  @return A request object
 */
+ (instancetype)requestWithPath:(NSString *)path
                     HTTPMethod:(NSString *)HTTPMethod
                         params:(NSDictionary *)params
                   timeInterval:(NSTimeInterval)timeInterval;

/**
 *  A lite method of `requestWithServerType:path:HTTPMethod:params:timeInterval:`.
 *  `HTTPMethod` = `HTTPMethodGET`, `cacheTimeInterval` = `TNCacheIntervalNone`
 *
 *  @param serverType   Server type, must in serverTypeHTTP, serverTypeDynamicHTTP, serverTypeHTTPS, serverTypeChat
 *  @param path         Request path, can not be nil
 *  @param params       Request params
 *
 *  @return A request object
 */
+ (instancetype)requestWithServerType:(NSString *)serverType
                                 path:(NSString *)path
                               params:(NSDictionary *)params;

/**
 *  A lite method of `requestWithServerType:path:HTTPMethod:params:timeInterval:`.
 *  `cacheTimeInterval` = `TNCacheIntervalNone`
 *
 *  @param serverType   Server type, must in serverTypeHTTP, serverTypeDynamicHTTP, serverTypeHTTPS, serverTypeChat
 *  @param path         Request path, can not be nil
 *  @param HTTPMethod   HTTP request method, 'GET', 'POST' etc.
 *  @param params       Request params
 *
 *  @return A request object
 */
+ (instancetype)requestWithServerType:(NSString *)serverType
                                 path:(NSString *)path
                           HTTPMethod:(NSString *)HTTPMethod
                               params:(NSDictionary *)params;

/**
 *  Factory method, build a reuqest object
 *
 *  @param serverType   Server type, must in serverTypeHTTP, serverTypeDynamicHTTP, serverTypeHTTPS, serverTypeChat
 *  @param path         Request path, can not be nil
 *  @param HTTPMethod   HTTP request method, 'GET', 'POST' etc.
 *  @param params       Request params
 *  @param timeInterval Cache time interval, in seconds
 *
 *  @return A request object
 */
+ (instancetype)requestWithServerType:(NSString *)serverType
                                 path:(NSString *)path
                           HTTPMethod:(NSString *)HTTPMethod
                               params:(NSDictionary *)params
                         timeInterval:(NSTimeInterval)timeInterval;

@end
