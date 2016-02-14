//
//  GLButtonCardView.h
//  Demos
//
//  Created by gaolong on 16/2/8.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLButtonCardModel;
@class GLButtonCardData;
@protocol GLButtonCardViewDelegate <NSObject>

- (void)cardViewDidSelectedWithModel:(GLButtonCardModel *)cardModel;

@end

@interface GLButtonCardView : UIView

@property (nonatomic, weak) id <GLButtonCardViewDelegate> delegate;

- (void)bindModel:(GLButtonCardData *)cardData;

@end

@interface GLButtonCardCell : UICollectionViewCell

- (void)bindModel:(GLButtonCardModel *)cardModel;

@end