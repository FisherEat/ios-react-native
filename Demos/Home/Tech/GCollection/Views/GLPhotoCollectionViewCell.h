//
//  GLPhotoCollectionViewCell.h
//  Demos
//
//  Created by gaolong on 16/6/22.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLPhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@end
