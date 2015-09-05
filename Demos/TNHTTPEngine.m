//
//  TNHTTPEngine.m
//  Demos
//
//  Created by schiller on 15/9/2.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "TNHTTPEngine.h"
#import "AFHTTPRequestOperation.h"
#import "TNServerURLConfig.h"
#import "AFNetWorking.h"
#import "TNBase64JSONRequestOperation.h"
#import "DeliveryMacros.h"
#import "TNBase64.h"
#import "TNJSONModel.h"

static NSString *const kPathKey = @"path";
static NSString *const kRequestTypeKey = @"requestType";
static NSString *const kCacheIntevalKey = @"cacheInteval";
static NSString *const kServerTypeKey = @"serverType";
static NSString *const kResponseClassNameKey = @"responseClassName";
static NSString *const kModernInterfaceKey = @"modernInterface";
static NSSet *presettingServerTypes = nil;

NSString *const TNResponseErrorDomain = @"com.tuniu.httpResponseError";
NSString *const TNHTTPRequestDidStartNotification = @"TNHTTPRequestDidStartNotification";
NSString *const TNHTTPRequestDidEndNotification = @"TNHTTPRequestDidEndNotification";
NSString *const TNHTTPNotificationUserInfoRequest = @"TNHTTPNotificationUserInfoRequest";

@interface TNHTTPEngine ()
@property (nonatomic, strong) NSSet *serverTypeSet;
@property (nonatomic, strong) NSDictionary *configDic;
@property (nonatomic, strong) NSMutableDictionary *HTTPClientDic;
@property (nonatomic, strong) NSMutableDictionary *HTTPClients;
@property (nonatomic, assign) NSUInteger maxHTTPRequestID;
@property (nonatomic, strong) NSMutableDictionary *operationDic;
@property (nonatomic, strong) dispatch_queue_t responseQueue;

@end
@implementation TNHTTPEngine

static TNHTTPEngine *_defaultEngine = nil;

+ (TNHTTPEngine *)defaultEngine
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultEngine = [[super allocWithZone:NULL] init];
    });
    return _defaultEngine;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self defaultEngine];
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadConfigFile
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"HTTPRequestConfig" ofType:@"plist"];
    
    @synchronized(_configDic)
    {
        _configDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    
}


#pragma mark - HTTP client 
- (NSString *)serverTypeForModernAPI:(NSString *)serverType
{
    return [NSString stringWithFormat:@"modern_%@", serverType];
}

- (void)registerHTTPClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _HTTPClientDic = [NSMutableDictionary dictionary];
    });
    [self registerHTTPClientWithBaseURL:HTTP_URL_LEGACY serverType:serverTypeHTTP];
    [self registerHTTPClientWithBaseURL:HTTPS_URL_LEGACY serverType:serverTypeHTTPS];
    [self registerHTTPClientWithBaseURL:DYNAMIC_HTTP_URL_LEGACY serverType:serverTypeDynamicHTTP];
    [self registerHTTPClientWithBaseURL:CHAT_URL_LEGACY serverType:serverTypeChat];
    [self registerHTTPClientWithBaseURL:HTTP_URL_MODERN serverType:[self serverTypeForModernAPI:serverTypeHTTP]];
    [self registerHTTPClientWithBaseURL:HTTPS_URL_MODERN serverType:[self serverTypeForModernAPI:serverTypeHTTPS]];
    [self registerHTTPClientWithBaseURL:DYNAMIC_HTTP_URL_MODERN serverType:[self serverTypeForModernAPI:serverTypeDynamicHTTP]];
    [self registerHTTPClientWithBaseURL:CHAT_URL_MODERN serverType:[self serverTypeForModernAPI:serverTypeChat]];
    [self registerHTTPClientWithBaseURL:CUSTOMERSERVICE_URL_MODERN serverType:[self serverTypeForModernAPI:serverTypeCustomerService]];
    [self registerHTTPClientWithBaseURL:JAVA_HTTP_MODERN serverType:[self serverTypeForModernAPI:serverTypeJavaHTTP]];
    [self registerHTTPClientWithBaseURL:JAVA_HTTPS_MODERN serverType:[self serverTypeForModernAPI:serverTypeJavaHTTPS]];
    [self registerHTTPClientWithBaseURL:STAT_HTTP_LEGACY serverType:serverTypeStatHTTP];
    [self registerHTTPClientWithBaseURL:STAT_HTTP_MODERN serverType:[self serverTypeForModernAPI:serverTypeStatHTTP]];

}

- (AFHTTPClient *)clientWithURLString:(NSString *)URLString
{
    AFHTTPClient *httpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:URLString]];
    [httpClient registerHTTPOperationClass:[TNBase64JSONRequestOperation class]];
    return httpClient;
}

- (BOOL)registerHTTPClientWithBaseURL:(NSString *)URLString serverType:(NSString *)serverType
{
    AFHTTPClient *client = [self clientWithURLString:URLString];
    if (!client)
    {
        return NO;
    }
    
    @synchronized(_HTTPClientDic)
    {
        _HTTPClientDic[serverType] = client;
       // TNLogDebug(@"Add http client with server type:{%@} url:{%@}", serverType, URLString);
    }
    return YES;

}

- (AFHTTPClient *)registerHTTPClientWithBaseURL:(NSString *)URLString
{
    AFHTTPClient *client = [self clientWithURLString:URLString];
    if (client)
    {
        @synchronized(self.HTTPClients)
        {
            self.HTTPClients[URLString] = client;
           // TNLogDebug(@"Add http client with server url:{%@}", URLString);
        }
    }
    
    return client;
}

- (AFHTTPClient *)clientWithRequest:(TNBaseHTTPRequest *)requset
{
    if (requset.baseURL)
    {
        AFHTTPClient *client = nil;
        
        @synchronized(self.HTTPClients)
        {
            client = self.HTTPClients[requset.baseURL];
        }
        
        return client ?: [self registerHTTPClientWithBaseURL:requset.baseURL];
    }
    
    // TODO: Delete the follow block
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        presettingServerTypes = [NSSet setWithObjects:serverTypeHTTP, serverTypeHTTPS, serverTypeDynamicHTTP,serverTypeChat, serverTypeCustomerService,serverTypeJavaHTTP,serverTypeJavaHTTPS,serverTypeStatHTTP, nil];
    });
    
    NSString *serverType = nil;
    
    if ([presettingServerTypes containsObject:requset.serverType])
    {
        serverType = requset.modernInterface ? [self serverTypeForModernAPI:requset.serverType] : requset.serverType;
    }
    else
    {
        serverType = requset.serverType;
    }
    
    AFHTTPClient *client = nil;
    
    @synchronized(_HTTPClientDic)
    {
        client = _HTTPClientDic[serverType];
    }
    
    return client;
}

- (NSString *)clientInfoJSONString
{
    static NSMutableDictionary *clientInfoDic = nil;
    if (!clientInfoDic)
    {
        clientInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"ct":@(TN_iOS_CLIENT_TYPE),
                                                                        @"dt":@(TN_iOS_DEVICE_TYPE),
//                                                                        @"v":[TNUtils appVersion],
//                                                                        @"cc":[GVUserDefaults standardUserDefaults].selectedStartCityCode}
                                                                        }];
    }
    //clientInfoDic[@"p"] = @(TN_iOS_PARTNER_NUM);
   // clientInfoDic[@"cc"] = [GVUserDefaults standardUserDefaults].selectedStartCityCode;
    
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:clientInfoDic
                                                       options:0
                                                         error:nil];
    return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
}

- (NSURLRequest *)URLRequestWithLegacyRequest:(TNBaseHTTPRequest *)request
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:request.params];
    //params[@"version"] = [TNUtils appVersion];
   // params[@"partner"] = @(TN_iOS_PARTNER_NUM);
    params[@"clientType"] = @(TN_iOS_CLIENT_TYPE);
    params[@"deviceType"] = @(TN_iOS_DEVICE_TYPE);
    //params[@"_currentCityCode"] = [GVUserDefaults standardUserDefaults].selectedStartCityCode;
    
    AFHTTPClient *HTTPClient = [self clientWithRequest:request];
    
    NSMutableURLRequest *URLRequest = [HTTPClient requestWithMethod:request.HTTPMethod
                                                               path:request.path
                                                         parameters:nil];
    
    if (params)
    {
        NSData *JSONData = [NSJSONSerialization dataWithJSONObject:params
                                                           options:0
                                                             error:nil];
        NSString *base64ParamString = [JSONData tn_base64EncodedString];
        
        NSMutableString *URLString = [NSMutableString stringWithString:HTTPClient.baseURL.absoluteString];
        [URLString appendString:request.path];
        
        if ([request.HTTPMethod isEqualToString:@"GET"]
            || [request.HTTPMethod isEqualToString:@"HEAD"]
            || [request.HTTPMethod isEqualToString:@"DELETE"])
        {
            BOOL dynamic = !request.resetful || ![request.serverType isEqualToString:serverTypeHTTP];
            
            [URLString appendString:(!dynamic ? @"/" : @"?")];
            [URLString appendString:base64ParamString];
        }
        else
        {
            [URLRequest setHTTPBody:[base64ParamString dataUsingEncoding:NSUTF8StringEncoding]];
        }
        URLRequest.URL = [NSURL URLWithString:URLString];
    }
    
    return URLRequest;
}

- (NSURLRequest *)URLRequestWithModernRequest:(TNBaseHTTPRequest *)request
{
    AFHTTPClient *HTTPClient = [self clientWithRequest:request];
    
    //  See, http://wiki.tuniu.org/pages/viewpage.action?pageId=37325453
    NSMutableString *path = [NSMutableString stringWithString:request.path];
    
    NSDictionary *params = request.params;
    
    if (!params)
    {
        params = [NSDictionary dictionary];
    }
    NSData *paramsJSONData = [NSJSONSerialization dataWithJSONObject:params
                                                             options:0
                                                               error:nil];
    NSString *paramJSONString = [[NSString alloc] initWithData:paramsJSONData encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *URLRequest = nil;
    
    // If you want to try to maintain this block. I strongly advice that you should give up!
    // No one knows the stupid protocool!!!
    
    if ([request.HTTPMethod isEqualToString:HTTPMethodPOST])
    {
        URLRequest = [HTTPClient requestWithMethod:request.HTTPMethod
                                              path:path
                                        parameters:nil];
        
        NSMutableString *URLString = [NSMutableString stringWithString:URLRequest.URL.absoluteString];
        [URLString appendFormat:@"?c=%@", [[self clientInfoJSONString] URLEncodedString]];
        URLRequest.URL = [NSURL URLWithString:URLString];
        URLRequest.HTTPBody = paramsJSONData;
    }
    else
    {
        if (!request.resetful
            || ![request.serverType isEqualToString:serverTypeHTTP])
        {
            URLRequest = [HTTPClient requestWithMethod:request.HTTPMethod
                                                  path:path
                                            parameters:@{@"c":[self clientInfoJSONString],
                                                         @"d":paramJSONString}];
        }
        else
        {
            URLRequest = [HTTPClient requestWithMethod:request.HTTPMethod
                                                  path:path
                                            parameters:nil];
            
            NSMutableString *URLString = [NSMutableString stringWithString:URLRequest.URL.absoluteString];
            [URLString appendFormat:@"/c/%@", [[self clientInfoJSONString] URLEncodedString]];
            if ([paramJSONString length] > 0)
            {
                [URLString appendFormat:@"/d/%@", [paramJSONString URLEncodedString]];
            }
            URLRequest.URL = [NSURL URLWithString:URLString];
        }
    }
    
    return URLRequest;
}

#pragma mark - Parse response

- (id)parseResponseObject:(id)responseObject
           responseString:(NSString *)responseString
                  request:(TNBaseHTTPRequest *)request
                    error:(NSError **)error
{
    NSString *JSONString = responseString;
    *error = nil;
    if (!request.modernInterface) // Legacy
    {
        // Parse response object
        JSONString = [NSString tn_stringWithBase64EncodedString:responseString];
    }
    
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!JSONData)
    {
        *error = [NSError errorWithDomain:TNResponseErrorDomain
                                     code:TNResponseCodeNilResponse
                                 userInfo:@{NSLocalizedFailureReasonErrorKey:@"Get a nil response object"}];
        return nil;
    }
    
    NSDictionary *JSONDic = [NSJSONSerialization JSONObjectWithData:JSONData
                                                            options:0
                                                              error:nil];
    if ([JSONDic count] == 0)
    {
        *error = [NSError errorWithDomain:TNResponseErrorDomain
                                     code:TNResponseCodeParsingFailure
                                 userInfo:@{NSLocalizedFailureReasonErrorKey:@"Failed to parse response object"}];
        return JSONDic;
    }
    
   // TNLogInfo(@"Receive request(requestId:%@) response {%@}", @(request.requestID), JSONDic);
    
    BOOL success = [JSONDic[@"success"] boolValue];
    
    if (!success
        || [JSONDic[@"errorCode"] integerValue] != TNResponseCodeSuccess)
    {
        NSString *errorInfo = JSONDic[@"msg"];
        *error = [NSError errorWithDomain:TNResponseErrorDomain
                                     code:[JSONDic[@"errorCode"] integerValue]
                                 userInfo:@{NSLocalizedFailureReasonErrorKey:errorInfo}];
        return JSONDic;
    }
    
    id responseModel = JSONDic[@"data"];
    
    if (!responseModel)
    {
        *error = [NSError errorWithDomain:TNResponseErrorDomain
                                     code:TNResponseCodeNoData
                                 userInfo:@{NSLocalizedFailureReasonErrorKey:@"Business error, stupid server, give my data back!!!"}];
        return JSONDic;
    }
    
    Class responseClass = NSClassFromString(request.responseModelClassString);
    // responseObject can be parsed
    if ([responseClass isSubclassOfClass:[TNJSONModel class]])
    {
        responseModel = [[responseClass alloc] initWithAttributes:responseModel];
    }
    
    if (request.cacheInterval > 0
        && [request.HTTPMethod isEqualToString:@"GET"])
    {
//        [[TNHTTPCacheManager defaultManager] cacheData:responseModel
//                                            forRequest:request];
    }
    
    return responseModel;
}

#pragma mark - Request control

- (AFHTTPRequestOperation *)operationWithRequestID:(TNHTTPRequestID)requestID
{
    AFHTTPRequestOperation *operation = nil;
    @synchronized(self.operationDic)
    {
        operation = self.operationDic[@(requestID)];
    }
    return operation;
}

- (void)sendHTTPRequest:(TNBaseHTTPRequest *)request callback:(void (^)(id, NSError *))block
{
    request.requestID = ++self.maxHTTPRequestID;
    
  //  TNLogInfo(@"Send request{%@}", request);
    
    // Check cache
    if (request.cacheInterval > 0
        && [request.HTTPMethod isEqualToString:@"GET"]) // Only "GET" method can be cached
    {
//        id cachedData = [[TNHTTPCacheManager defaultManager] cachedDataWithRequest:request];
//        
//        if (cachedData)
//        {
//            TNLogInfo(@"Request(requestId:%@) got cached data.", @(request.requestID));
//            dispatch_async(dispatch_get_main_queue(), ^{
//                block(cachedData, nil);
//            });
//            return;
//        }
    }
    
    // Match HTTP server
    AFHTTPClient *HTTPClient = [self clientWithRequest:request];
    
    NSURLRequest *URLRequest = request.modernInterface ? [self URLRequestWithModernRequest:request] : [self URLRequestWithLegacyRequest:request];
    
//    TNLogInfo(@"Parse request(requestId:%@) to url request{%@}", @(request.requestID), URLRequest);
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TNHTTPRequestDidStartNotification
                                                        object:nil
                                                      userInfo:@{TNHTTPNotificationUserInfoRequest:request}];
    AFHTTPRequestOperation *operation =
    [HTTPClient HTTPRequestOperationWithRequest:URLRequest
                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                            
                                            [[NSNotificationCenter defaultCenter] postNotificationName:TNHTTPRequestDidEndNotification
                                                                                                object:nil
                                                                                              userInfo:@{TNHTTPNotificationUserInfoRequest:request}];
                                            // Cancelled
                                            if (!self.operationDic[@(request.requestID)])
                                            {
                                                return;
                                            }
                                            
                                            NSError *error = nil;
                                            
                                            id responseModel = [self parseResponseObject:responseObject
                                                                          responseString:operation.responseString
                                                                                 request:request
                                                                                   error:&error];
                                            
                                            if (error)
                                            {
//                                                TNLogError(@"Request(requestId:%@) failed with error{%@}", @(request.requestID), error);
                                            }
                                            
                                            if (block)
                                            {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    block(responseModel, error);
                                                });
                                            }
                                            
                                            // Dettach operation with request ID
                                            @synchronized(self.operationDic)
                                            {
                                                [self.operationDic removeObjectForKey:@(request.requestID)];
                                            }
                                        }
                                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                            
                                            if (!self.operationDic[@(request.requestID)])
                                            {
                                                return;
                                            }
                                            
//                                            TNLogError(@"Request(requestId:%@) failed with error{%@}", @(request.requestID), error);
                                            
                                            if (block)
                                            {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    block(nil, error);
                                                });
                                            }
                                            
                                            // Dettach operation with request ID
                                            @synchronized(self.operationDic)
                                            {
                                                [self.operationDic removeObjectForKey:@(request.requestID)];
                                            }
                                        }];
    operation.successCallbackQueue = self.responseQueue;
    operation.failureCallbackQueue = self.responseQueue;
    @synchronized(self.operationDic)
    {
        if (!self.operationDic)
        {
            self.operationDic = [NSMutableDictionary dictionary];
        }
        // Attach operation with request ID
        self.operationDic[@(request.requestID)] = operation;
    }
    [HTTPClient.operationQueue addOperation:operation];
}

- (BOOL)cancelHTTPRequest:(TNHTTPRequestID)requestID
{
    AFHTTPRequestOperation *operation = [self operationWithRequestID:requestID];
    [operation cancel];
    // Dettach operation with request ID
    @synchronized(self.operationDic)
    {
        [self.operationDic removeObjectForKey:@(requestID)];
    }
    return YES;
}

#pragma mark - Notification handler

- (void)serverURLChanged:(NSNotification *)notification
{
    // Cancel all request
    @synchronized(_operationDic)
    {
        [_operationDic removeAllObjects];
    }
    
    for (NSString *key in self.serverTypeSet)
    {
        AFHTTPClient *client = _HTTPClientDic[key];
        [client.operationQueue cancelAllOperations];
        [_HTTPClientDic removeObjectForKey:key];
        NSString *warppedKey = [self serverTypeForModernAPI:key];
        client = _HTTPClientDic[warppedKey];
        [client.operationQueue cancelAllOperations];
        [_HTTPClientDic removeObjectForKey:warppedKey];
    }
    
    // Register with new URL
    [self registerHTTPClient];
}

- (void)uploadPhotosWithHTTPRequest:(TNBaseHTTPRequest *)request
                             photos:(NSArray *)photos
                           progress:(void (^)(NSUInteger bytes, long long totalBytes, long long totalBytesExpected))uploadProgressBlock
                           callback:(void (^)(id responseObject, NSError *error))block {
    
    request.requestID = ++self.maxHTTPRequestID;
    
    // Match HTTP server
    AFHTTPClient *HTTPClient = [self clientWithRequest:request];
    
    NSURLRequest *URLRequest = request.modernInterface ? [self URLRequestWithModernRequest:request] : [self URLRequestWithLegacyRequest:request];
//    NSDictionary *dic = @{@"sessionId":[NSUserDefaults standardUserDefaults].sessionID};
    NSDictionary *dic = @{@"sessionId": @(123456)};
    NSURLRequest *uploadRequest = [HTTPClient multipartFormRequestWithMethod:@"POST" path:URLRequest.URL.absoluteString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
//        for (TNCTravelTogetherPostPictureModel *picture in photos) {
//            NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:picture.picUrl]];
//            if (imageData) {
//                [formData appendPartWithFileData:imageData name:@"photos[]" fileName:picture.picUrl mimeType:@"image/jpeg"];
//            }
//        }
    }];
 //   TNLogDebug(@"RequestUrl:%@",uploadRequest.URL.absoluteString);
    
    AFHTTPRequestOperation *operation =
    [HTTPClient HTTPRequestOperationWithRequest:uploadRequest
                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                            
                                            // Cancelled
                                            if (!self.operationDic[@(request.requestID)])
                                            {
                                                return;
                                            }
                                            
                                            NSError *error = nil;
                                            
                                            id responseModel = [self parseResponseObject:responseObject
                                                                          responseString:operation.responseString
                                                                                 request:request
                                                                                   error:&error];
                                            
                                            if (error)
                                            {
//                                                TNLogError(@"Request(requestId:%@) failed with error{%@}", @(request.requestID), error);
                                            }
                                            
                                            if (block)
                                            {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    block(responseModel, error);
                                                });
                                            }
                                            
                                            // Dettach operation with request ID
                                            @synchronized(self.operationDic)
                                            {
                                                [self.operationDic removeObjectForKey:@(request.requestID)];
                                            }
                                        }
                                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                            
                                            if (!self.operationDic[@(request.requestID)])
                                            {
                                                return;
                                            }
                                            
//                                            TNLogError(@"Request(requestId:%@) failed with error{%@}", @(request.requestID), error);
                                            
                                            if (block)
                                            {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    block(nil, error);
                                                });
                                            }
                                            
                                            // Dettach operation with request ID
                                            @synchronized(self.operationDic)
                                            {
                                                [self.operationDic removeObjectForKey:@(request.requestID)];
                                            }
                                        }];
    operation.successCallbackQueue = self.responseQueue;
    operation.failureCallbackQueue = self.responseQueue;
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        uploadProgressBlock( bytesWritten,  totalBytesWritten, totalBytesExpectedToWrite);
    }];
    
    @synchronized(self.operationDic)
    {
        if (!self.operationDic)
        {
            self.operationDic = [NSMutableDictionary dictionary];
        }
        // Attach operation with request ID
        self.operationDic[@(request.requestID)] = operation;
    }
    [HTTPClient.operationQueue addOperation:operation];
}

@end
