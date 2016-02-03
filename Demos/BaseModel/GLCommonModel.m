//
//  GLCommonModel.m
//  Demos
//
//  Created by schiller on 16/2/3.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLCommonModel.h"

@interface GLCommonModel ()

@end

@implementation GLCommonModel

+ (void)getAppConfigInfoBlock:(DictionaryBlock)block
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistFileName = [path stringByAppendingString:@"AppVersion.plist"];
    if (![fileManager fileExistsAtPath:plistFileName]) {
        NSString *originPlistPath = [[NSBundle mainBundle] pathForResource:@"AppVersion" ofType:@"plist"];
        NSMutableArray *originCategoryVersion = [NSMutableArray arrayWithContentsOfFile:originPlistPath];
        [originCategoryVersion writeToFile:plistFileName atomically:YES];
    }
    NSMutableArray *updateCategoryVersion = [NSMutableArray arrayWithContentsOfFile:plistFileName];
    NSDictionary *params = @{@"packageList":updateCategoryVersion};
    GLRequest *request = [GLRequest requestWithPath:OFFICE_URL_APP_CONFIG params:params];
    [[GLNetwork sharedInstance] sendHTTPRequest:request callback:^(id responseObject, NSError *error) {
        if (!error) {
            block(responseObject,nil);
        }else {
            block(nil, error);
        }
    }];
}

@end
