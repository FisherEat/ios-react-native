//
//  PassValueBlockVC.h
//  Demos
//
//  Created by gaolong on 15/8/12.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PassBlock)(NSString *, NSNumber *);
typedef void(^ModelBlock)();

@interface PassValueBlockVC : UIViewController

@property (nonatomic, copy) PassBlock passBlock;

- (void)passValueByBlock:(PassBlock)aBlock;

//- (void)passValueByBlock:(ModelBlock)block;

@end
