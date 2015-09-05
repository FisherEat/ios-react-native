//
//  AFImageCache.h
//  TuNiuApp
//
//  Created by chen on 11/11/13.
//  Copyright (c) 2013 Yu Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFImageCache : NSCache
- (UIImage *)cachedImageForRequest:(NSURLRequest *)request;
- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request;
@end

