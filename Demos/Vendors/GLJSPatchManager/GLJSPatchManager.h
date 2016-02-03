//
//  GLJSPatchManager.h
//  Demos
//
//  Created by schiller on 16/2/3.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLJSPatchLoad : NSObject

@end

#define JSPatchManager [GLJSPatchManager sharedManager]

@interface GLJSPatchManager : NSObject

SINGLETON_INTERFACE(GLJSPatchManager, sharedManager)

/**
 * 通过url下载jspatch修复的zip包
 *
 * @param urlString
 */
- (void)loadJSPatchWithZipUrlString:(NSString *)urlString;

@end
