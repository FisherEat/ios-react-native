//
//  GURLRequest.h
//  test
//
//  Created by gaolong on 15/6/26.
//  Copyright (c) 2015年 gaolong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**
 *  网络交互类。
 *  该文档为接口文档，因此有属性部分和方法部分,属性为只读
 *  简化网络操作工具类。请求操作只返回成功数据代理，失败处理在本类中统一处理。
 *  该网络类是对AFNetworking 框架的封装
 */

/**
 *  @brief  POST／GET方法均首先将参数json格式化，然后传输到servive服务器端
 *  服务器端接收数据需要先反序列化，然后解读。
 *  本类中传输的数据格式为json ，由于json数据本身是array 或者字典类型，
 *  因此要非常注意传输的数据类型
 */

/**
 *  @brief  例如: 图片和视频的存储，可以存储为字典，key 为键，value 为视频或者图片的地址
            通过字典 的 key 取出url，然后从网络上下载. sendSyncyRequest 方法和 imageWithData 方法。
 */

@interface GURLRequest : NSObject

// 网络交互操作类，所有的操作通过该实例完成。
@property (nonatomic,strong,readonly) AFHTTPSessionManager *sessionManager ;

// 网络交互基站点，可为域名或者IP地址，必须初始化
@property (nonatomic,strong,readonly) NSURL *baseURL ;

/**
 *  GURLRequest单例返回方法
 *
 *  @warning 应始终通过单例获取
 *  @return  返回GURLRequest单例
 */
+ (instancetype)sharedInstance ;

- (void)cancelRequest ;

/**
 *  @brief                   post方式请求网络
 *
 *  @param path              请求地址的路径，无需路径则为nil
 *  @param params            请求的参数，无需参数则为nil
 *  @param tag               请求标志
 *  @param completionHandler 请求完后进入的代理，返回相应的数据或者错误信息
 *
 */

- (void)postForPath:(NSString *)path withParams:(NSDictionary *)params withTag:(NSUInteger)tag completionHandler:(void(^)(id data, NSError *error ,NSUInteger tag))completionHandler;

// 不带tag标记的post请求，其它如上
- (void)postForPath:(NSString *)path withParams:(NSDictionary *)param completionHandler:(void(^)(id data, NSError *error ))completionHandler;

/**
 *  @brief  get方法请求网络
 *
 *  @param path              请求地址的路径，无需则为nil
 *  @param params            请求的参数，无需则为nil。该参数可以是字典类型或者数组类型
                             AFNetworking 会自动对其进行格式转换为json 、data二进制传输
 *  @param completionHandler 请求完成后进入的代理，返回相应的数据和错误信息
 */
- (void)getForPath:(NSString *)path withParams:(NSDictionary *)params completionHandler:(void(^)(id data,NSError *error))completionHandler ;

/**
 *  @brief  带tag标记的get请求，其它如上
 *
 */

- (void)getForPath:(NSString *)path withParams:(NSDictionary *)params  withTag:(NSUInteger)tag completionHandler:(void (^)(id data, NSError *error,NSInteger tag))completionHandler;

/**
 *  @brief  下载文件
 *
 *  @param fileUrl           现在链接
 *  @param path              下载到所在的文件路径
 *  @param completionHandler 请求完成后进入的代理，返回相应的数据或者错误信息
 */
+ (void)downloadFile:(NSString *)fileUrl toPath:(NSString *)path completionHandler:(void(^)(id data,NSError *error))completionHandler ;

/**
 *  @brief  上传文件
 *
 *  @param filePath          上传文件的路径
 *  @param fileName          上传文件的文件名
 *  @param params            上传文件中的一些附加参数信息
 *  @param taPath            上传到目的地址的链接
 *  @param completionHandler 请求完成以后进入的代理，返回相应的数据或者错误信息
 *  @param percent           上传过程中显示上传的百分比
 */
+ (void)uploadFile:(NSString *)filePath withFileName:(NSString *)fileName withParam:(NSDictionary *)params toPath:(NSString *)taPath completionHandler:(void(^)(id data,NSError *error))completionHandler percent:(void(^)(CGFloat per))percent;

/**
 *  @brief  同步请求数据
 *
 *  @param urlPath           请求地址的完整url
 *  @param params            请求参数
 *  @param completionHandler 请求完成以后进入的代理，返回相应的数据或者错误信息。
 */
+ (void)synchronousRequest:(NSString *)urlPath withParams:(NSDictionary *)params completionHandler:(void(^)(id data, NSError *error))completionHandler ;

@end
