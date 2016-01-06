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

+ (void)loginWithInput:(PersonModel *)input completion:(void (^)(NSDictionary *, NSError *))block
{
    NSDictionary *params = [input mj_keyValues];
    GLRequest *request = [GLRequest requestWithPath:BASE_URL_LOG_IN params:params];
    [[GLNetwork sharedInstance] sendHTTPRequest:request callback:^(id responseObject, NSError *error) {
        NSDictionary *dic = [NSDictionary dictionary];
        if (error) {
            if (block) {
                block(@{@"message": @"error happened."}, error);
            }else{
                NSString *errorString = [NSString stringWithFormat:@"Error: %@", error];
                mAlert(@"Error", errorString, @"Cancel", @"OK");
            }
        }else {
            dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            block(dic, error);
        }
    }];
}

@end
