//
//  ButtonDemoVC.h
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassMesageDelegate <NSObject>

- (NSString *)passValues:(NSString *)values;

@end

@interface ButtonDemoVC : UIViewController

@property (nonatomic, weak) id<PassMesageDelegate> delegate;
@property (nonatomic, copy) void (^passMsgBlock)(NSString *);/* <block传值 */

@end

