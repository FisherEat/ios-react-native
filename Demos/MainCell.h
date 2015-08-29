//
//  MainCell.h
//  Demos
//
//  Created by schiller on 15/8/29.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *Headerphoto;

@end
