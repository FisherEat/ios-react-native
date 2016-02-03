//
//  GLNetwork.m
//  Demos
//
//  Created by gaolong on 15/12/31.
//  Copyright © 2015年 schiller. All rights reserved.
//

#import "GLNetwork.h"
#import "GLRequest.h"
#import "AFNetworking.h"
@interface GLNetwork ()

@end

@implementation GLNetwork

SINGLETON_IMPLEMENTION(GLNetwork, sharedInstance)

- (void)sendHTTPRequest:(GLRequest *)request callback:(void (^)(id, NSError *))block
{
    NSURLSessionConfiguration *configuraion = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuraion];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   
    NSMutableURLRequest *newRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:request.httpMethod URLString:request.path parameters:request.params error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:newRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
        if (block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(responseObject, error);
            });
        }
    }];
    
    [dataTask resume];
}

- (void)downLoadHTTPRequest:(GLRequest *)request success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableURLRequest *newRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:request.httpMethod URLString:request.path parameters:request.params error:nil];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:newRequest progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            if (success) {
                success(filePath);
            }
            NSLog(@"file has been downloaded to: %@", filePath);
        }else {
            failure(error);
        }
    }];
    
    [downloadTask resume];
}

@end
