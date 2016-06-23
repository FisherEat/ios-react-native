//
//  GLPhotoFlowLayout.m
//  Demos
//
//  Created by gaolong on 16/6/22.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLPhotoFlowLayout.h"

@implementation GLPhotoFlowLayout

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//对layoutAttrute根据需要做调整，如frame,alpha,transform等
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attrsArray = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = self.collectionView.frame.size.width*0.5 + self.collectionView.contentOffset.x;
    for (UICollectionViewLayoutAttributes *attr in attrsArray) {
        CGFloat length = 0.f;
        if (attr.center.x > centerX) {
            length = attr.center.x - centerX;
        }else {
            length = centerX - attr.center.x;
        }
        
        CGFloat scale = 1 - length / self.collectionView.frame.size.width;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attrsArray;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
{
    //某cell滑动停止的时候最终rect
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0.f;
    rect.size = self.collectionView.frame.size;
    //计算collectionView最中心点的x值。
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    //计算super已经计算好的布局属性
    CGFloat offset = 0.0f;
    NSArray *attrsArray = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attr in attrsArray) {
        if (attr.center.x - centerX > 10 || centerX - attr.center.x > 10) {
            offset = attr.center.x - centerX;
            // 此刻，cell的center的x和此刻CollectionView的中心点的距离
        }
    }
    proposedContentOffset.x += offset;

    return  proposedContentOffset;
}

//http://www.jianshu.com/p/efc19dce1270?utm_campaign=maleskine&utm_content=note&utm_medium=mobile_all_hots&utm_source=recommendation
@end
