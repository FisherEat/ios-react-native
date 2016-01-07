//
//  UIImageView+GLExtensions.m
//  Demos
//
//  Created by schiller on 16/1/7.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "UIImageView+GLExtensions.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (GLExtensions)

- (void)gl_setImageWithURL:(NSURL *)url
{
    [self gl_setImageWithURL:url placeholderImage:nil];
}

- (void)gl_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage
{
    [self gl_setImageWithURL:url
                      option:GLWebImageOptionsRetryFailed
            placeholderImage:placeholderImage];
}

- (void)gl_setImageWithURL:(NSURL *)url option:(GLWebImageOptions)option placeholderImage:(UIImage *)placeholderImage
{
    [self gl_setImageWithURL:url
                      option:option placeholderImage:placeholderImage ompleted:nil];
    
}

- (void)gl_setImageWithURL:(NSURL *)url option:(GLWebImageOptions)option placeholderImage:(UIImage *)placeholderImage ompleted:(void (^)(UIImage *, NSError *, NSURL *))completedBlock
{
    SDWebImageOptions sdWebOptions = 0;
    if (option & GLWebImageOptionsProgressiveDownload) {
        sdWebOptions |= SDWebImageProgressiveDownload;
    }
    if (option & GLWebImageOptionsRefreshCached) {
        sdWebOptions |= SDWebImageRefreshCached;
    }
    [self sd_setImageWithURL:url placeholderImage:placeholderImage options:sdWebOptions completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            mAlert(@"Error", @"SDWebImage Error", @"Cancel", @"OK");
        }else if (completedBlock) {
             completedBlock(image, error, imageURL);
        }else {
            
        }
    }];
}

- (void)gl_cancelCurrentImageLoad
{
    [self sd_cancelCurrentImageLoad];
}

@end
