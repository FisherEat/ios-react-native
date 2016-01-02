//
//  GLLoginManager.h
//  Demos
//
//  Created by gaolong on 16/1/1.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PersonModel;
@interface GLLoginManager : NSObject

+ (void)loginWithInput:(PersonModel *)input completion:(void(^)(NSDictionary *callBackDic, NSError *erro))block;

@end
