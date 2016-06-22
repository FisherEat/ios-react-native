//
//  GLThirdTableViewCell.h
//  Demos
//
//  Created by gaolong on 16/6/22.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLThirdTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIImageView *icon;

- (void)bindModel:(id)model;

@end
