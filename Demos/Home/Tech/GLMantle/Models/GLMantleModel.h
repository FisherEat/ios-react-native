//
//  GLMantleModel.h
//  Demos
//
//  Created by schiller on 16/7/7.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLMantleModel : NSObject

@end

@interface GLCommunityTripActivityItem : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString *title;  //标题
@property (nonatomic, strong) NSString *picUrl; //图片地址
@property (nonatomic, strong) NSString *url; //跳转url
@end

@interface GLCommunityTripActivity : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSString *shareUrl; //游记首页分享
@property (nonatomic, strong) NSArray <GLCommunityTripActivityItem *>*activityList;

+ (void)communityTripChannelActivity:(void (^)(GLCommunityTripActivity *response, NSError *error))block;
@end