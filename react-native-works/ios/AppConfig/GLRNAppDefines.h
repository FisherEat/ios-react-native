//
//  GLRNAppDefines.h
//  rnToday_2
//
//  Created by gaolong on 16/4/16.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BoolBlock) (BOOL flag, NSError *error);
typedef void(^VoidBlock) (void);

//方法简写
#define mAlert(title, msg, cancel, other)   [[[UIAlertView alloc] initWithTitle:title \
message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:other, nil] show]

#define kAlert(msg) [[[UIAlertView alloc] initWithTitle:@"提示" \
message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil] show]
#define  mDocumentDir [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, \
                      NSUserDomainMask, YES) firstObject]