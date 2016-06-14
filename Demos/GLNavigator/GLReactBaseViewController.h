//
//  GLReactBaseViewController.h
//  Demos
//
//  Created by schiller on 16/6/14.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTBridge.h"

@interface GLReactBaseViewController : UIViewController

@property (nonatomic, strong) RCTBridge *bridge;
@property (nonatomic, copy) NSString *moduleName;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *params;

@end
