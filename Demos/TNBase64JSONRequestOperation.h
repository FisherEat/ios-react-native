//
//  AFBase64JSONRequestOperation.h
//  TuNiuApp
//
//  Created by Yu Liang on 13-8-15.
//  Copyright (c) 2013年 Yu Liang. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@interface TNBase64JSONRequestOperation : AFHTTPRequestOperation

@property (readonly, nonatomic, strong) id responseJSONBase64Object;
@property (readwrite, nonatomic, strong) NSString* errorMessage;

@end
