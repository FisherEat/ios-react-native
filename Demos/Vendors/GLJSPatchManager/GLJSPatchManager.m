//
//  GLJSPatchManager.m
//  Demos
//
//  Created by schiller on 16/2/3.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLJSPatchManager.h"
#import "SSZipArchive.h"

typedef void (^BoolBlock) (BOOL flag, NSError *error);
typedef void (^VoidBlock) (void);
@interface GLJSPatchManager ()

@property (nonatomic, strong) NSString *urlString;

@end

@implementation GLJSPatchManager

SINGLETON_IMPLEMENTION(GLJSPatchManager, sharedManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadJSPatchWithZipUrlString:(NSString *)urlString
{
    self.urlString = urlString;
    if (![NSString isNilOrEmpty:self.urlString]) {
        if ([self needDownload]) {
            //先下载
            [self downLoadFileFinish:^(BOOL flag, NSError *error) {
                if (flag) {
                    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
                    [userdefault setObject:[[self.urlString componentsSeparatedByString:@"/"] lastObject] forKey:@"jsPatchZipName"];
                    [userdefault synchronize];
                    [self unzipFileResult:^{
                        
                    }];
                }
            }];
        }
    }
}

- (BOOL)needDownload
{
    NSString *newName = [[self.urlString componentsSeparatedByString:@"/"] lastObject];
    if ([newName isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"jsPatchZipName"]]) { //如果有最新的zip包，则下载，否则不下载
        return NO;
    }else {
        return YES;
    }
}

- (void)downLoadFileFinish:(BoolBlock)block
{
    if ([NSString isNilOrEmpty:self.urlString]) {
        return;
    }
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask,YES) objectAtIndex:0];
    NSString *fileName = [[self.urlString componentsSeparatedByString:@"/"] lastObject];
    doc = [doc stringByAppendingString:fileName];
    GLRequest *request = [GLRequest requestWithPath:self.urlString HTTPMethod:@"GET" params:nil];
    
    [[GLNetwork sharedInstance] downLoadHTTPRequest:request success:^(id responseObject) {
        mAlert(@"提示", @"下载jspatch脚本成功", @"OK", @"Cancel");
        block(YES, nil);
    } failure:^(NSError *error) {
        mAlert(@"提示", @"下载jspatch脚本失败", @"OK", @"Cancel");
        block(NO, error);
    }];
}

- (void)unzipFileResult:(VoidBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *newName = [[self.urlString componentsSeparatedByString:@"/"] lastObject];
        NSString *directory = [doc stringByAppendingString:newName];
        [SSZipArchive unzipFileAtPath:directory toDestination:doc];
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    });
}

@end
