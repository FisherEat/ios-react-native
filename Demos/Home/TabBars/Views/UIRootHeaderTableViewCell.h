//
//  UIRootHeaderTableViewCell.h
//  Demos
//
//  Created by gaolong on 16/2/10.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIRootBaseTableViewCell.h"

@protocol GLRootSingleViewCellDelegate <NSObject>

- (void)singleCellDidClicked:(GLRootSingelCellModel *)cellModel;

@end

@interface UIRootHeaderTableViewCell : UIRootBaseTableViewCell

@end

@interface GLRootHomeButtonViewCell : UIRootBaseTableViewCell

@end

@interface GLRootHomeSingleViewCell : UIRootBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *accessoryImg;
@property (nonatomic, strong) XTOnePixelLine *bottomLine;
@property (nonatomic, assign) GLTestDemoTypeCell cellID;
@property (nonatomic, weak) id<GLRootSingleViewCellDelegate> delegate;

@end