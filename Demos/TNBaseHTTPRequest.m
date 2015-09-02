//
//  TNBaseHTTPRequest.m
//  Demos
//
//  Created by schiller on 15/7/25.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "TNBaseHTTPRequest.h"
#import "NSString+TNExtends.h"

NSString *const serverTypeHTTP = @"HTTP";
NSString *const serverTypeDynamicHTTP = @"dynamicHTTP";
NSString *const serverTypeHTTPS = @"HTTPS";
NSString *const serverTypeChat = @"chat";

// [6.0.4]add by linfeng. 服务端为客服加了这么一个新域名
NSString *const serverTypeCustomerService = @"customerService";

NSString *const serverTypeJavaHTTP = @"JavaHttp";
NSString *const serverTypeJavaHTTPS = @"JavaHttps";
NSString *const serverTypeStatHTTP = @"STAT";//统计的接口，只有崩溃搜集用

NSString *const HTTPMethodGET = @"GET";
NSString *const HTTPMethodPOST = @"POST";

@interface TNBaseHTTPRequest ()

@property (nonatomic, copy) NSString *serverType;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *HTTPMethod;
@property (nonatomic, copy) NSString *innerCacheFileName;

@end

@implementation TNBaseHTTPRequest

+ (instancetype)requestWithPath:(NSString *)path params:(NSDictionary *)params
{
    return [self requestWithServerType:serverTypeHTTP
                                  path:path
                            HTTPMethod:HTTPMethodGET
                                params:params
                          timeInterval:TNCacheIntervalNone];
}

+ (instancetype)requestWithPath:(NSString *)path HTTPMethod:(NSString *)HTTPMethod params:(NSDictionary *)params
{
    return [self requestWithPath:path HTTPMethod:HTTPMethod params:params timeInterval:TNCacheIntervalNone];
}

+ (instancetype)requestWithPath:(NSString *)path HTTPMethod:(NSString *)HTTPMethod params:(NSDictionary *)params timeInterval:(NSTimeInterval)timeInterval
{
    TNBaseHTTPRequest *request = [[self alloc] init];
    request.path = path;
    request.HTTPMethod = HTTPMethod;
    request.params = params;
    request.cacheInterval = timeInterval;
    return request;
}

+ (instancetype)requestWithServerType:(NSString *)serverType path:(NSString *)path params:(NSDictionary *)params
{
    return [self requestWithServerType:serverType
                                  path:path
                            HTTPMethod:HTTPMethodGET
                                params:params
                          timeInterval:TNCacheIntervalNone];
}

+ (instancetype)requestWithServerType:(NSString *)serverType
                                 path:(NSString *)path
                           HTTPMethod:(NSString *)HTTPMethod
                               params:(NSDictionary *)params
{
    return [self requestWithServerType:serverType
                                  path:path
                            HTTPMethod:HTTPMethod
                                params:params
                          timeInterval:TNCacheIntervalNone];
}

+ (instancetype)requestWithServerType:(NSString *)serverType
                                 path:(NSString *)path
                           HTTPMethod:(NSString *)HTTPMethod
                               params:(NSDictionary *)params
                         timeInterval:(NSTimeInterval)timeInterval
{
    TNBaseHTTPRequest *request = [[self alloc] init];
    request.serverType = serverType;
    request.path = path;
    request.HTTPMethod = HTTPMethod;
    request.params = params;
    request.cacheInterval = timeInterval;
    return request;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self addObserver:self
               forKeyPath:@"params"
                  options:0
                  context:NULL];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"params"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@:%p>:{\n%@,\nrequestId:%@,\nparam:%@,\nresponseClassString:%@}\n",
            NSStringFromClass([self class]),
            self,
            self.modernInterface ? @"Modern" : @"Legacy",
            @(self.requestID),
            self.params,
            self.responseModelClassString];
}

- (BOOL)isRestful
{
    return YES;
}

- (NSString *)cacheFileName
{
    if (self.innerCacheFileName)
    {
        return self.innerCacheFileName;
    }
    
    NSMutableString *fileName = [NSMutableString string];
    [fileName appendString:self.path];
    
    if ([self.params count] > 0)
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.params
                                                           options:0
                                                             error:nil];
        if (jsonData)
        {
            [fileName appendString:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        }
    }
    
    self.innerCacheFileName = [fileName MD5Hash];
    
    return self.innerCacheFileName;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"params"])
    {
        self.innerCacheFileName = nil;
    }
}

@end
