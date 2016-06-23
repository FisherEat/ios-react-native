//
//  GLWeiboComposeViewController.h
//  Demos
//
//  Created by schiller on 16/6/23.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLBarViewController.h"

typedef NS_ENUM(NSUInteger, WBStatusComposeViewType) {
    WBStatusComposeViewTypeStatus,  ///< 发微博
    WBStatusComposeViewTypeRetweet, ///< 转发微博
    WBStatusComposeViewTypeComment, ///< 发评论
};

@interface GLWeiboComposeViewController : GLBarViewController
@property (nonatomic, assign) WBStatusComposeViewType type;
@end
