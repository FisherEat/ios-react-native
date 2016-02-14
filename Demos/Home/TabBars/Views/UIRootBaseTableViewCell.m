//
//  UIRootBaseTableViewCell.m
//  Demos
//
//  Created by gaolong on 16/2/10.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "UIRootBaseTableViewCell.h"

@interface UIRootBaseTableViewCell ()

@end

@implementation UIRootBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    
}

+ (id)cellForTableView:(UITableView *)tableView withIdentifier:(NSString *)cellId cellType:(GLRootHomeCellType)cellType
{
    UITableViewCell *cell = nil;
    Class cellClass = NSClassFromString(cellId);
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[cellClass class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

+ (CGFloat)cellHeight:(id)model
{
    return 0;
}

- (void)bindModel:(id)model
{
    
}

@end
