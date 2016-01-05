//
//  OButton.m
//  Demos
//
//  Created by schiller on 15/7/21.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "OButton.h"

@implementation OButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.cornerRadius = 5;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.layer.backgroundColor = [UIColor colorWithRed:0.7 green:0.5 blue:0.8 alpha:1].CGColor;
    }
    
    return self;
    
}

@end
