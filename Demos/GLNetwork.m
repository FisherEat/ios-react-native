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

@end
