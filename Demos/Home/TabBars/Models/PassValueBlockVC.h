//
//  PassValueBlockVC.h
//  Demos
//
//  Created by gaolong on 15/8/12.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassValueDelegate <NSObject>

- (void)passValueByDelegate:(NSString *)delegate;

@end

typedef void(^PassBlock)(NSString *, NSNumber *);
typedef void(^ModelBlock)();

@interface PassValueBlockVC : UIViewController

@property (nonatomic, copy) PassBlock passBlock;

@property (nonatomic, weak) id<PassValueDelegate> delegate;

- (void)passValueByBlock:(PassBlock)aBlock;

@end
