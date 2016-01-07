//
//  MainCell.m
//  Demos
//
//  Created by schiller on 15/8/29.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *photoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 70, 70)];
        self.Headerphoto = photoImgView;
        [self.contentView addSubview:self.Headerphoto];
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 200, 25)];
        self.nameLabel = nameLabel;
        self.nameLabel.text = @"name";
        [self.contentView addSubview:self.nameLabel];
        
        UILabel *postLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 30, 200, 25)];
        self.positionLabel = postLable;
        self.positionLabel.text = @"position";
        [self.contentView addSubview:self.positionLabel];
        
        UILabel *comLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 55, 200, 25)];
        self.companyLabel = comLable;
        self.companyLabel.text = @"company";
        [self.contentView addSubview:self.companyLabel];
        
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
