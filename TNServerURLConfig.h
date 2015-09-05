//
//  TNServerURLConfig.h
//  XTrain
//
//  Created by Ben on 14/11/13.
//  Copyright (c) 2014年 Tuniu. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const TNServerUrlChanged;

#ifdef DEBUG
    #define NET_CONFIG_FILE_NAME @"NetworkConfig-R"
#else
    #define NET_CONFIG_FILE_NAME @"NetworkConfig-R"
#endif

#define RELEASE_NET_CONFIG   @"NetworkConfig-R"
#define M_P_NET_CONFIG       @"NetworkConfig-PR"
#define M145_NET_CONFIG      @"NetworkConfig-145"
#define M_SIT_NET_CONFIG     @"NetworkConfig-Sit"
#define ORG_NET_CONFIG       @"NetworkConfig-D"

#define HTTP_URL_LEGACY                 ([TNServerURLConfig sharedConfig].legacyHTTPURLString)
#define DYNAMIC_HTTP_URL_LEGACY         ([TNServerURLConfig sharedConfig].legacyDynamicHTTPURLString)
#define HTTPS_URL_LEGACY                ([TNServerURLConfig sharedConfig].legacyHTTPSURLString)
#define SSO_URL_LEGACY                  ([TNServerURLConfig sharedConfig].legacySSOURLString)
#define CHAT_URL_LEGACY                 ([TNServerURLConfig sharedConfig].legacyChatURLString)
#define HTTP_URL_MODERN                 ([TNServerURLConfig sharedConfig].modernHTTPURLString)
#define DYNAMIC_HTTP_URL_MODERN         ([TNServerURLConfig sharedConfig].modernDynamicHTTPURLString)
#define HTTPS_URL_MODERN                ([TNServerURLConfig sharedConfig].modernHTTPSURLString)
#define SSO_URL_LEGACY_MODERN           ([TNServerURLConfig sharedConfig].modernSSOURLString)
#define CHAT_URL_MODERN                 ([TNServerURLConfig sharedConfig].modernChatURLString)
#define CUSTOMERSERVICE_URL_MODERN      ([TNServerURLConfig sharedConfig].modernCustomerServiceURLString)
#define JAVA_HTTP_MODERN                ([TNServerURLConfig sharedConfig].modernJavaHTTPURLString)
#define JAVA_HTTPS_MODERN               ([TNServerURLConfig sharedConfig].modernJavaHTTPSURLString)
#define STAT_HTTP_LEGACY                ([TNServerURLConfig sharedConfig].legacyStatHTTPURLString)
#define STAT_HTTP_MODERN                ([TNServerURLConfig sharedConfig].modernStatHTTPURLString)

static NSString *const TNNetWorkConfigName = @"TNNetWorkConfig";

@interface TNServerURLConfig : NSObject

@property (nonatomic, strong, readonly) NSString *legacyHTTPURLString;
@property (nonatomic, strong, readonly) NSString *modernHTTPURLString;
@property (nonatomic, strong, readonly) NSString *legacyDynamicHTTPURLString;
@property (nonatomic, strong, readonly) NSString *modernDynamicHTTPURLString;
@property (nonatomic, strong, readonly) NSString *legacyHTTPSURLString;
@property (nonatomic, strong, readonly) NSString *modernHTTPSURLString;
@property (nonatomic, strong, readonly) NSString *legacySSOURLString;
@property (nonatomic, strong, readonly) NSString *modernSSOURLString;
@property (nonatomic, strong, readonly) NSString *legacyChatURLString;
@property (nonatomic, strong, readonly) NSString *modernChatURLString;
@property (nonatomic, strong, readonly) NSString *modernCustomerServiceURLString;
@property (nonatomic, strong, readonly) NSString *modernJavaHTTPURLString;
@property (nonatomic, strong, readonly) NSString *modernJavaHTTPSURLString;
@property (nonatomic, strong, readonly) NSString *legacyStatHTTPURLString;
@property (nonatomic, strong, readonly) NSString *modernStatHTTPURLString;

/**
 *  Singleton method
 *
 *  @return Singleton object
 */
+ (TNServerURLConfig *)sharedConfig;

/**
 *  Load default config
 */
- (void)loadDefaultConfig;

/**
 *  Config URLs，config URLs at runtime
 *
 *  @param dictionary URL dictionary
 */
- (void)configURLWithDictonary:(NSDictionary *)dictionary;

/**
 *  Change URLs
 *
 * @param configName network name
 */

- (void)changeUrls:(NSString *)urlType;

@end
