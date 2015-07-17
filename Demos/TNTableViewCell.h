//
//  TNTableViewCell.h
//  gl
//
//  Created by schiller on 15/7/15.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNTableViewCell : UITableViewCell

+ (NSString *)cellIdentifier;
+ (id)cellForTableView:(UITableView *)tableView;

- (id)initWithCellIdentifier:(NSString *)cellID;

- (UIViewController *)viewControllerFromStoryboard:(NSString *)stroyboardName identifier:(NSString *)identifier;

+ (CGFloat)calculateCellHeightWithData:(id)cellData;

- (void)bindModel:(id)cellData;

+ (CGFloat)cellHeight;

@end
