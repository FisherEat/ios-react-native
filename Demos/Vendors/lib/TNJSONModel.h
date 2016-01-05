//
//  YCJSONModel.h
//  YC
//
//  Created by Yu Liang on 13-8-13.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "TNHTTPClient.h"
//#import "TNDynamicHTTPClient.h"
//#import "TNHTTPSClient.h"
//#import "ApiUrlsMacros.h"
//#import "CacheMacros.h"

@interface TNJSONModel : NSObject <NSCoding, NSCopying, NSMutableCopying>

@property (nonatomic, assign) BOOL isCache;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end


//Http request callback blocks
typedef void (^VoidBlock)(void);
typedef void (^StringBlock)(NSString *info, NSError *error);
typedef void (^BoolBlock)(BOOL flag, NSError *error);
typedef void (^ModelBlock)(TNJSONModel *model, NSError *error);
typedef void (^ArrayBlock)(NSMutableArray *models, NSError *error);
typedef void (^DictionaryBlock)(NSMutableDictionary *infoDict, NSError *error);
typedef void (^PageArrayBlock)(NSInteger totalPage, NSMutableArray *models, NSError *error);