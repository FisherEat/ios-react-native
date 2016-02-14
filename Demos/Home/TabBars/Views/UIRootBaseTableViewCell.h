//
//  UIRootBaseTableViewCell.h
//  Demos
//
//  Created by gaolong on 16/2/10.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLRootHomeDatas.h"

@interface UIRootBaseTableViewCell : UITableViewCell

+ (id)cellForTableView:(UITableView *)tableView withIdentifier:(NSString *)cellId cellType:(GLRootHomeCellType)cellType;

+ (CGFloat)cellHeight:(id)model;

- (void)bindModel:(id)model;

@end
