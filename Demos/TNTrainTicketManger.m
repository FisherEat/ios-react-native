//
//  TNTrainTicketManger.m
//  Demos
//
//  Created by schiller on 15/7/25.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "TNTrainTicketManger.h"
#import "TNBaseHTTPRequest.h"
#import "AFNetworking.h"
#import "GURLRequest.h"

#define TRAIN_ADLIST  @"train/product/adList"

@interface TNTrainTicketManger ()

@property (nonatomic, weak) NSString *selectedStartCityCode;
@property (nonatomic, assign) NSUInteger maxHTTPRequestID;
@property (nonatomic, strong) NSMutableArray *adList;

@end

@implementation TNTrainTicketManger

static TNTrainTicketManger *_sharedInstance = nil;

+ (TNTrainTicketManger *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[super allocWithZone:NULL] init];
    });
    return _sharedInstance;
    
}

 + (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

/**
 * @author Edited by schiller, 15-07-25 16:07:56
 *
 * @brief  该方法为获取火车票头部广告页面的方法，用到较多的网络请求知识
 *
 * @param dataBlock
 */
- (void)fetchAdDataWithCompletion:(dataBlock)dataBlock
{
    
}



@end
