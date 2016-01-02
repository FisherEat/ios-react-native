//
//  GLNetwork.h
//  Demos
//
//  Created by gaolong on 15/12/31.
//  Copyright © 2015年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLRequest;
@interface GLNetwork : NSObject

SINGLETON_INTERFACE(GLNetwork, sharedInstance)

- (void)sendHTTPRequest:(GLRequest *)request callback:(void(^)(id responseObject, NSError *error))block;

@end
