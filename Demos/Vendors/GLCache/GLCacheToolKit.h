//
//  GLCacheToolKit.h
//  Demos
//
//  Created by schiller on 16/2/3.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GLCacheContentType)
{
    GLCacheContentTypeNormal,
    GLCacheContentTypeOneDay,
    GLCacheContentTypeThreeDays,
    GLCacheContentTypeOneWeek
};

@interface GLCacheToolKit : NSObject

+ (id)sharedCache;

- (id)cacheContentForKey:(NSString *)key withCacheType:(GLCacheContentType)type;

- (void)setCacheContent:(id <NSCopying>)content forKey:(NSString *)key withCacheType:(GLCacheContentType)type;

- (void)removeCacheContentForKey:(NSString *)key withCacheType:(GLCacheContentType)type;

- (void)removeAllCacheContentWithCacheType:(GLCacheContentType)type;

@end
