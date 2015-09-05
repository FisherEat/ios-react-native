//
//  TNServerURLConfig.m
//  XTrain
//
//  Created by Ben on 14/11/13.
//  Copyright (c) 2014年 Tuniu. All rights reserved.
//

#import "TNServerURLConfig.h"

NSString *const TNServerUrlChanged = @"TNServerUrlChanged";

@implementation TNServerURLConfig

static TNServerURLConfig *_sharedConfig = nil;

+ (TNServerURLConfig *)sharedConfig
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConfig = [[super allocWithZone:NULL] init];
    });
    return _sharedConfig;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedConfig];
}

- (void)loadDefaultConfig
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *configName = [defaults objectForKey:TNNetWorkConfigName];
    
    if (configName)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:configName ofType:@"plist"];
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
        [[TNServerURLConfig sharedConfig] configURLWithDictonary:dictionary];

    }
    else
    {
        //load default config
        NSString *file = [[NSBundle mainBundle] pathForResource:NET_CONFIG_FILE_NAME ofType:@"plist"];
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:file];
        [self configURLWithDictonary:dictionary];
    }
    
}

- (void)changeUrls:(NSString *)urlType
{
    NSString *file = [[NSBundle mainBundle] pathForResource:urlType ofType:@"plist"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:file];
    [[TNServerURLConfig sharedConfig] configURLWithDictonary:dictionary];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:urlType forKey:TNNetWorkConfigName];
    [defaults synchronize];
    
}

- (void)configURLWithDictonary:(NSDictionary *)dictionary
{
    BOOL modified = NO;
    for (NSString *key in dictionary.allKeys)
    {
        NSDictionary *dic = dictionary[key];
        
        if ([key isEqualToString:@"HTTP"])
        {
            _legacyHTTPURLString = dic[@"legacy"];
            _modernHTTPURLString = dic[@"modern"];
            modified = YES;
        }
        else if ([key isEqualToString:@"HTTPS"])
        {
            _legacyHTTPSURLString = dic[@"legacy"];
            _modernHTTPSURLString = dic[@"modern"];
            modified = YES;
        }
        else if ([key isEqualToString:@"dynamicHTTP"])
        {
            _legacyDynamicHTTPURLString = dic[@"legacy"];
            _modernDynamicHTTPURLString = dic[@"modern"];
            modified = YES;
        }
        else if ([key isEqualToString:@"SSO"])
        {
            _legacySSOURLString = dic[@"legacy"];
            _modernSSOURLString = dic[@"modern"];
            modified = YES;
        }
        else if ([key isEqualToString:@"chat"])
        {
            _legacyChatURLString = dic[@"legacy"];
            _modernChatURLString = dic[@"modern"];
            modified = YES;
        }else if ([key isEqualToString:@"customerService"])
        {
            _modernCustomerServiceURLString = dic[@"modern"];
            modified = YES;
        }
        else if ([key isEqualToString:@"JavaHTTP"])
        {
            _modernJavaHTTPURLString = dic[@"modern"];
            modified = YES;
        }
        else if ([key isEqualToString:@"JavaHTTPS"])
        {
            _modernJavaHTTPSURLString = dic[@"modern"];
            modified = YES;
        }
        else if ([key isEqualToString:@"STAT"])
        {
            _legacyStatHTTPURLString = dic[@"legacy"];
            _modernStatHTTPURLString = dic[@"modern"];
            modified = YES;
        }
    }
    
    if (modified)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:TNServerUrlChanged
                                                            object:nil];
    }
}
@end
