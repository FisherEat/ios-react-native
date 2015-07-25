//
//  GURLRequest.m
//  test
//
//  Created by gaolong on 15/6/26.
//  Copyright (c) 2015年 gaolong. All rights reserved.
//

#import "GURLRequest.h"
#import "config.h"
#import "BlocksKit.h"

static GURLRequest *SINGLETON = nil ;
//测试地址
#define N_HostSite             @""
#define mWeakSelf  __weak typeof (self)weakSelf = self;

//默认请求Tag 为－1
static NSInteger const gDefaultTag = -1 ;

//判断是否是通过单例方法获取实例，若不是，则抛出异常
static BOOL isFirstAccess = YES ;

@interface GURLRequest()

//请求管理器
@property (nonatomic,strong,readwrite) AFHTTPSessionManager *sessionManager ;
//基站点url
@property (nonatomic,strong,readwrite) NSURL *baseURL ;

@end
@implementation GURLRequest

/**
 *  @brief  sharedInstance/init/defautlInit 这三个函数的目的都是为了初始化
 *  初始化过程中，定义的static 静态变量要格外注意。
 *  @return 返回一个单例
 */
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO ;
        SINGLETON = [[GURLRequest alloc]init];
    });
    return SINGLETON ;
}

- (instancetype)init
{
    if (SINGLETON) {
        return SINGLETON ;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    if (self) {
        [self defautlInit];
    }
    return self ;
}

/**
 *  @brief  默认初始化 GORLRequest单例
 */
- (void)defautlInit
{
    self.baseURL = [NSURL URLWithString:N_HostSite];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30 ;
    configuration.timeoutIntervalForResource = 30 ;
    self.sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:self.baseURL sessionConfiguration:configuration];
    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"application/json", @"text/plain",@"image/png",nil];
    
}

- (void)postForPath:(NSString *)path withParams:(NSDictionary *)param completionHandler:(void (^)(id, NSError *))completionHandler
{
    [self postForPath:path withParams:param withTag:gDefaultTag completionHandler:^(id data, NSError *error, NSUInteger tag) {
        if (completionHandler) {
            completionHandler(data,error);
        }
    }];
    
}

- (void)postForPath:(NSString *)path withParams:(NSDictionary *)params withTag:(NSUInteger)tag completionHandler:(void (^)(id, NSError *, NSUInteger))completionHandler
{
    [self.sessionManager POST:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
    {
        if (completionHandler) {
            completionHandler(responseObject,nil,tag);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        if (completionHandler) {
            completionHandler(nil,error,tag);
        }
        
    }];
    
}

- (void)getForPath:(NSString *)path withParams:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler
{
    [self getForPath:path withParams:params withTag:gDefaultTag completionHandler:^(id data, NSError *error, NSInteger tag) {
        if (completionHandler) {
            completionHandler(data,error);
        }
    }];
}

- (void)getForPath:(NSString *)path withParams:(NSDictionary *)params withTag:(NSUInteger)tag completionHandler:(void (^)(id data, NSError *error, NSInteger tag))completionHandler
{
    [self.sessionManager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (completionHandler) {
             completionHandler(responseObject,nil,tag);
     }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         if (completionHandler) {
             completionHandler(nil,error,tag);
         }
     }];
    
}

+ (void)downloadFile:(NSString *)fileUrl toPath:(NSString *)path completionHandler:(void (^)(id, NSError *))completionHandler
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"application/json", @"text/plain", nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileUrl]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
                                                                     progress:nil
                                                                  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response)
                                              {
                                                  return [NSURL fileURLWithPath:path];
                                              }
                                                            completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error)
                                              {
                                                  if (completionHandler) {
                                                      completionHandler(filePath.path, error);
                                                  }
                                              }];
    [downloadTask resume];
    
}

+ (void)uploadFile:(NSString *)filePath withFileName:(NSString *)fileName withParam:(NSDictionary *)params toPath:(NSString *)taPath completionHandler:(void (^)(id, NSError *))completionHandler percent:(void (^)(CGFloat))percent
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:taPath] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:160];
    
    NSString *bounary = @"AaB03x";
    NSString *endBounary = [[NSString alloc]initWithFormat:@"\r\n--%@--",bounary];
    NSMutableString *bodyStr = [[NSMutableString alloc]init];
    for (NSString *key in params.allKeys) {
        [bodyStr appendFormat:@"--%@\r\n", bounary];
        [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
        [bodyStr appendFormat:@"%@\r\n", params[key]];
    }
    
    [bodyStr appendFormat:@"--%@\r\n", bounary];
    [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", fileName];
    [bodyStr appendFormat:@"Content-Type: video/mpeg4\r\n\r\n"];
    
    NSMutableData *bodyData = [NSMutableData data];
    [bodyData appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[NSData dataWithContentsOfFile:filePath]];
    [bodyData appendData:[endBounary dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *contentType=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@", bounary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%zd", [bodyData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:bodyData];
    [request setHTTPMethod:@"POST"];
    
    mWeakSelf ;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if (completionHandler) {
                                              [weakSelf bk_performBlock:^{
                                                  if (error) {
                                                      completionHandler(nil, error);
                                                  } else {
                                                      NSError *err = nil;
                                                      id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
                                                      if (err) {
                                                          NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                          completionHandler(str, err);
                                                      } else {
                                                          completionHandler(responseObject, err);
                                                      }
                                                  }
                                              } onQueue:dispatch_get_main_queue() afterDelay:0];
                                          }
                                      }];
    [dataTask resume];
    
    /// 计算上传进度
    [self bk_performBlockInBackground:^{
        CGFloat tmpPer = 0.0;
        do {
            if (percent) {
                CGFloat per = (CGFloat)dataTask.countOfBytesSent/(CGFloat)dataTask.countOfBytesExpectedToSend;
                if (dataTask.countOfBytesExpectedToSend == 0) {
                    per = 0;
                }
                
                if (per - tmpPer > 0.01) {
                    tmpPer = per;
                    [weakSelf bk_performBlock:^{
                        percent(per);
                    } onQueue:dispatch_get_main_queue() afterDelay:0];
                }
            }
        } while (dataTask.countOfBytesSent < [bodyData length]);
    } afterDelay:0];

    
}

+ (void)synchronousRequest:(NSString *)urlPath withParams:(NSDictionary *)params completionHandler:(void (^)(id data, NSError *error))completionHandler
{
    NSMutableString *json = [NSMutableString string];
    for (NSString *key in params.allKeys) {
        [json appendFormat:@"%@=%@,", key, params[key]];
    }
    NSError *error = nil;
    NSData *bodyData = [json dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    if (error) {
        if (completionHandler) {
            completionHandler(nil, error);
            return;
        }
    }
    
    NSString *bodyLength = [NSString stringWithFormat:@"%zd", bodyData.length];
    NSURL *url = [NSURL URLWithString:urlPath];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:bodyLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:bodyData];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (completionHandler) {
        completionHandler(dict, error);
    }
}


@end
