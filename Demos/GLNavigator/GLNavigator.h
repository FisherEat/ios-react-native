//
//  GLNavigator.h
//  Demos
//
//  Created by gaolong on 16/2/5.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLNavigationMap.h"

@interface GLNavigator : NSObject

@property (nonatomic, strong, readonly) GLNavigationMap *map;

SINGLETON_INTERFACE(GLNavigator, navigator)

- (BOOL)to:(NSString *)URLString;

- (BOOL)to:(NSString *)URLString extraParams:(NSDictionary *)params;

@end
