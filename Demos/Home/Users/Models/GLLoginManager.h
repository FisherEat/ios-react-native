//
//  GLLoginManager.h
//  Demos
//
//  Created by gaolong on 16/1/1.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PersonModel;
@class PersonData;
@class PersonDetail;
@interface GLLoginManager : NSObject

+ (void)loginWithInput:(PersonModel *)input completion:(void(^)(PersonData *results, NSError *erro))block;

@end
