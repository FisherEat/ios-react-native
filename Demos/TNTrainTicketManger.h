//
//  TNTrainTicketManger.h
//  Demos
//
//  Created by schiller on 15/7/25.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^dataBlock)(NSArray *, NSError *);

@interface TNTrainTicketManger : NSObject

+ (TNTrainTicketManger *)sharedInstance;

#pragma mark - Advertise

- (void)fetchAdDataWithCompletion:(dataBlock)dataBlock;

@end
