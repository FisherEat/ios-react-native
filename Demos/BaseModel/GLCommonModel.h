//
//  GLCommonModel.h
//  Demos
//
//  Created by schiller on 16/2/3.
//  Copyright © 2016年 schiller. All rights reserved.
//

typedef void (^DictionaryBlock)(NSMutableDictionary *infoDict, NSError *error);

#import <Foundation/Foundation.h>

@interface GLCommonModel : NSObject

+ (void)getAppConfigInfoBlock:(DictionaryBlock)block;

@end
