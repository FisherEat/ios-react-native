//
//  GLHeaderView.m
//  Demos
//
//  Created by gaolong on 15/8/30.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "GLHeaderView.h"
#import "UIButton+Position.h"

@implementation GLHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *headerButton = [UIButton createButtonWithFrame:CGRectMake(10, 10, 18, 12) Target:self  Image:@"arrow_down" ImagePressed:@"arrow_up"];
        self.headerButton = headerButton;
        [self.headerButton addTarget:self action:@selector(toggleCell) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:headerButton];
    }
    return self;
}

- (void)toggleCell
{
    
}
@end
