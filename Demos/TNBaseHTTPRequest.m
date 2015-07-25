//
//  TNBaseHTTPRequest.m
//  Demos
//
//  Created by schiller on 15/7/25.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "TNBaseHTTPRequest.h"
#import "NSString+TNExtends.h"

NSString *const serverTypeHTTP        = @"HTTP";
NSString *const serverTypeDynamicHTTP = @"dynamicHTTP";
NSString *const serverTypeHTTPS       = @"HTTPS";
NSString *const serverTypeChat        = @"chat";

NSString *const HTTPMethodGET = @"GET";
NSString *const HTTPMethodPOST = @"POST";

@interface TNBaseHTTPRequest ()

@property (nonatomic, copy) NSString *serverType;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *HTTPMethod;
@property (nonatomic, copy) NSString *innerCacheFileName;

@end

@implementation TNBaseHTTPRequest

+ (instancetype)requstWithPath:(NSString *)path param:(NSDictionary *)params
{
    return [self requestWithServerType:serverTypeHTTP
                           path:path
                     HTTPMethod:HTTPMethodGET
                          params:params
                   timeInterval:TNCacheIntervalNone];
    
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
    self = [super init];
    if (self) {
        self.modernInterface = YES;
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

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"params"]) {
        self.innerCacheFileName = nil;
    }
    
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

- (NSString *)cacheFileName
{
    if (self.innerCacheFileName) {
        return self.innerCacheFileName;
    }
    
    NSMutableString *fileName = [NSMutableString string];
    [fileName appendString:self.path];
    
    if ([self.params count] > 0) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.params
                                                           options:0
                                                             error:nil];
        if (jsonData) {
            [fileName appendString:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        }
    }
    
    self.innerCacheFileName = [fileName MD5Hash];
    
    return self.innerCacheFileName;
    
}



@end
