//
//  GLLoginView.h
//  Demos
//
//  Created by gaolong on 16/1/1.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLLoginButtonClickedDelegate <NSObject>

- (void)loginWithName:(NSString *)name password:(NSString *)password;

@end

@interface GLLoginView : UIView

@property (nonatomic, weak)id<GLLoginButtonClickedDelegate>delegate;

@end
