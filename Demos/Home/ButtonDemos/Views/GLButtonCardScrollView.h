//
//  GLButtonCardScrollView.h
//  Demos
//
//  Created by gaolong on 16/2/8.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLButtonCardCatogeryViewDelegate <NSObject>

- (void)tapAction;

@end

@interface GLButtonCardScrollView : UICollectionReusableView

@end

@interface GLButtonCardPackageScrollView : UIView

- (void)bindModel:(id)model;

@end

@interface GLButtonCardCatogeryView : UIView

- (void)bindData:(id)data;

@property (nonatomic, weak) id<GLButtonCardCatogeryViewDelegate>delegate;

@end