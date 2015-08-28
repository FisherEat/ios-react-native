//
//  GLPresentViewController.h
//  Demos
//
//  Created by gaolong on 15/8/27.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "GLBarViewController.h"
#import "TNTableViewCell.h"

@interface GLPresentViewController : GLBarViewController

@end

@interface GLPresentInfoCell : TNTableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UIImageView *imgView;

- (void)bindModel:(NSDictionary *)cellData;

@end