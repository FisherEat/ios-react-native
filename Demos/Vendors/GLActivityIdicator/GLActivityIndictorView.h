//
//  GLActivityIndictorView.h
//  Demos
//
//  Created by gaolong on 16/2/7.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLActivityIndictorView : UIView

@property (nonatomic, assign) BOOL hidesWhenStopped;

- (void)startAnimating;
- (void)stopAnimating;

@end
