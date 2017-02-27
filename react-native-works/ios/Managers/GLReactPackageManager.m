//
//  GLReactPackageManager.m
//  rnToday_2
//
//  Created by gaolong on 16/4/16.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "GLReactPackageManager.h"
#import "XTURLRequest.h"
//#import "SSZipArchive.h"

@interface GLReactPackageManager ()

@property(nonatomic, copy) NSString *urlString;

@end

@implementation GLReactPackageManager

SINGLETON_IMPLEMENTION(GLReactPackageManager, sharedManager)

- (void)loadJSPackageWithUrlString:(NSString *)urlString
{
  self.urlString = urlString;
  if (self.urlString) {
    if ([self needDownload]) {//是否需要下载
      [self downLoadFileFinished:^(BOOL flag, NSError *error) {
        if (flag) {
          NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
          [userDefault setObject:[[self.urlString componentsSeparatedByString:@"/"] lastObject] forKey:@"ReactJSPackageZipName"];
          [userDefault synchronize];
          [self unzipJSFileResult:^{
            [self loadJSReactScript];
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
  if ([newName isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"ReactJSPackageZipName"]]) {
    return NO;
  }else {
    return YES;
  }
}

- (void)downLoadFileFinished:(BoolBlock)block
{
  if (!self.urlString) {
    return;
  }
  NSString *fileName = [[self.urlString componentsSeparatedByString:@"/"] lastObject];
  NSURL *documentDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
 NSString *destination = [[documentDirectoryURL URLByAppendingPathComponent:fileName] absoluteString];
  [XTURLRequest downloadFile:self.urlString toPath:destination completionHandler:^(NSString *aFilePath, NSError *error) {
    if (error) {
      mAlert(@"提示", @"下载jspatch脚本失败", @"OK", @"Cancel");
      block(NO ,error);
    }else {
        mAlert(@"提示", @"下载react脚本成功", @"OK", @"Cancel");
      block(YES, nil);
    }
  }];
}

- (void)unzipJSFileResult:(VoidBlock)block
{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSString *newName = [[self.urlString componentsSeparatedByString:@"/"] lastObject];
    NSString *directory = [NSString stringWithFormat:@"%@/%@", mDocumentDir, newName];
 //   [SSZipArchive unzipFileAtPath:directory toDestination:mDocumentDir];
    dispatch_async(dispatch_get_main_queue(), ^{
      block();
    });
  });
}

- (void)loadJSReactScript
{
  [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadJSDataFromLocal" object:nil];
}

@end
