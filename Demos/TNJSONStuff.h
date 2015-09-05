//
//  NSDictionary+JSON.h
//  TuNiuApp
//
//  Created by Ben on 15/1/21.
//  Copyright (c) 2015年 Tuniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)

- (id)tn_objectFromJSONString;

@end

@interface NSDictionary (JSON)

- (NSString *)tn_JSONString;

@end

@interface NSData (JSON)

- (id)tn_JSONObject;

@end
