//
//  GLJSPatchManager.m
//  Demos
//
//  Created by schiller on 16/2/3.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLJSPatchManager.h"
#import "SSZipArchive.h"
#import "JPEngine.h"

typedef void (^BoolBlock) (BOOL flag, NSError *error);
typedef void (^VoidBlock) (void);

@implementation GLJSPatchLoad

+ (NSArray *)fetchScriptsArray
{
    return @[];
}

@end

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
    if (self.urlString) {
        if ([self needDownload]) {
            //先下载
            [self downLoadFileFinish:^(BOOL flag, NSError *error) {
                if (flag) {
                    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
                    [userdefault setObject:[[self.urlString componentsSeparatedByString:@"/"] lastObject] forKey:@"jsPatchZipName"];
                    [userdefault synchronize];
                    [self unzipFileResult:^{
                        [self loadJSPatchScript];
                    }];
                }else {
                    kAlert(@"下载失败，无法解压！");
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
    if (!self.urlString) {
        return;
    }
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask,YES) objectAtIndex:0];
    NSString *fileName = [[self.urlString componentsSeparatedByString:@"/"] lastObject];
    doc = [doc stringByAppendingPathComponent:fileName];
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
        NSString *directory = [doc stringByAppendingPathComponent:newName];
        [SSZipArchive unzipFileAtPath:directory toDestination:doc];
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    });
}

/**
 * @brief  加在js脚本
 */
- (void)loadJSPatchScript
{
    [JPEngine startEngine];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *directory = [doc stringByAppendingPathComponent:@"js"];
    NSString *loadFileName = [directory stringByAppendingPathComponent:@"load.js"];
    if ([fileManager fileExistsAtPath:loadFileName]) {
        NSString *script = [NSString stringWithContentsOfFile:loadFileName encoding:NSUTF8StringEncoding error:nil];
        [JPEngine evaluateScript:script];
    }
    NSArray *scriptNameArray = [GLJSPatchLoad fetchScriptsArray];
    [scriptNameArray enumerateObjectsUsingBlock:^(NSString *fileName, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *fullPath = [directory stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:fullPath] && [[fileName pathExtension] isEqualToString:@"js"]) {
            NSString *script = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:nil];
            [JPEngine evaluateScript:script];
        }
    }];
}

@end
