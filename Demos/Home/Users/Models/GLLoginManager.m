//
//  GLLoginManager.m
//  Demos
//
//  Created by gaolong on 16/1/1.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLLoginManager.h"
#import "PersonModel.h"
#import "GLRequest.h"
#import "MJExtension.h"

@implementation GLLoginManager

+ (void)loginWithInput:(PersonModel *)input completion:(void (^)(PersonData *results, NSError *))block
{
    NSDictionary *params = [input mj_keyValues];
    GLRequest *request = [GLRequest requestWithPath:OFFICE_URL_LOG_IN params:params];
    [[GLNetwork sharedInstance] sendHTTPRequest:request callback:^(id responseObject, NSError *error) {
        if (error) {
            NSString *errorString = [NSString stringWithFormat:@"Error: %@", error];
            mAlert(@"Error", errorString, @"Cancel", @"OK");
        }else {
            PersonData *result = nil;
            if (responseObject) {
                result = [PersonData mj_objectWithKeyValues:responseObject];
                block(result, nil);
            }else {
                block([PersonData new], nil);
            }
        }
    }];
}

@end
