//
//  UIImageView+GLExtensions.h
//  Demos
//
//  Created by schiller on 16/1/7.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, GLWebImageOptions) {
    GLWebImageOptionsRetryFailed = 1 << 0, //默认方式
    GLWebImageOptionsProgressiveDownload = 1 << 3,//图片边下载边显示
    GLWebImageOptionsRefreshCached = 1 << 4 ,//忽略缓存
};

@interface UIImageView (GLExtensions)

/**
 * @brief  deal with image with url
 *
 * @param url of image
 */
- (void)gl_setImageWithURL:(NSURL *)url;

/**
 * @brief  deal with image with placeholderImage
 *
 * @param url
 * @param placeholderImage
 */
- (void)gl_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholderImage;

/**
 * @brief  stragety of options
 *
 * @param url
 * @param option
 * @param placeholderImage
 */
- (void)gl_setImageWithURL:(NSURL *)url option:(GLWebImageOptions)option placeholderImage:(UIImage *)placeholderImage;

/**
 * @brief
 *
 * @param url
 * @param option
 * @param placeholderImage
 * @param completedBlock
 */
- (void)gl_setImageWithURL:(NSURL *)url option:(GLWebImageOptions)option placeholderImage:(UIImage *)placeholderImage ompleted:(void(^)(UIImage *image, NSError *error, NSURL *imageURL))completedBlock;

/**
 * @brief  cancel download image 
 */
- (void)gl_cancelCurrentImageLoad;
@end
