//
//  GLNetwork.h
//  Demos
//
//  Created by gaolong on 15/12/31.
//  Copyright © 2015年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLRequest;
@interface GLNetwork : NSObject

SINGLETON_INTERFACE(GLNetwork, sharedInstance)

/**
 * @brief  发送请求
 *
 * @param request 参数
 * @param block   回调
 */
- (void)sendHTTPRequest:(GLRequest *)request callback:(void(^)(id responseObject, NSError *error))block;

/**
 * @brief  下载请求
 *
 * @param request 请求
 * @param success 下载成功回调
 * @param failure 下载失败回调
 */
- (void)downLoadHTTPRequest:(GLRequest *)request
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;
@end
