//
//  TNHTTPEngine.h
//  Demos
//
//  Created by schiller on 15/9/2.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TNBaseHTTPRequest.h"

FOUNDATION_EXPORT NSString *const TNResponseErrorDomain;
FOUNDATION_EXPORT NSString *const TNHTTPRequestDidSartNotification;
FOUNDATION_EXPORT NSString *const TNHTTPRequestDidEndNotification;
FOUNDATION_EXPORT NSString *const TNHTTPNotificationUserInfoRequest;
FOUNDATION_EXPORT NSString *const TNHTTPNotificationUserInfoResponse;

typedef NS_ENUM(NSInteger, TNResponseCode)
{
    TNResponseCodeParsingFailure = 1000, // Failed to pasrse response string to JSON.
    TNResponseCodeNoData = 1001, // data = nil
    TNResponseCodeNilResponse = 1002, // responseObject = nil
    TNResponseCodeSuccess = 710000,
};

@interface TNHTTPEngine : NSObject

/**
 *  @author Edited by schiller
 *
 *  @brief  Singleton method
 *  @return Singleton object
 */

+ (TNHTTPEngine *)defaultEngine;

/**
 *  Register a HTTP client with custom URL.
 *  There are 4 build-in HTTP clients with type "HTTP", "dynamicHTTP", "HTTPS" and "chat".
 *  However, you can have your own client for your server.
 *
 *  @param URLString  Server url string
 *  @param serverType Server identifier, should be unique, like "HTTP", "dynamicHTTP" .etc
 *
 *  @return Success or not
 */
- (BOOL)registerHTTPClientWithBaseURL:(NSString *)URLString
                           serverType:(NSString *)serverType;
/**
 *  Send a HTTP request
 *
 *  @param block  callback block
 *
 *  @param request A TNBaseHTTPRequest object
 */
- (void)sendHTTPRequest:(TNBaseHTTPRequest *)request
               callback:(void (^)(id responseObject, NSError *error))block;
/**
 *  Cancel an HTTP request
 *
 *  @param requestID ID of a request
 *
 *  @return Success or not
 */
- (BOOL)cancelHTTPRequest:(TNHTTPRequestID)requestID;

/**
 *  Send a HTTP request
 *
 *  @param block  callback block
 *
 *  @param photos An array of UIImage.
 *
 *  @param request A TNBaseHTTPRequest object
 */
- (void)uploadPhotosWithHTTPRequest:(TNBaseHTTPRequest *)request
                             photos:(NSArray *)photos
                           progress:(void (^)(NSUInteger bytes, long long totalBytes, long long totalBytesExpected))uploadProgressBlock
                           callback:(void (^)(id responseObject, NSError *error))block;
@end
