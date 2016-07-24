//
//  GLScrollListView.h
//  Demos
//
//  Created by gaolong on 16/7/24.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLScrollListView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
- (void)configView:(NSArray *)array;
@end

@interface GLScrollListCell : UICollectionViewCell

@end