//
//  GLWeiboStatusXComposeTextParser.h
//  Demos
//
//  Created by schiller on 16/6/23.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYKit.h"

@interface GLWeiboStatusXComposeTextParser : NSObject<YYTextParser>

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *highlightTextColor;

@end
