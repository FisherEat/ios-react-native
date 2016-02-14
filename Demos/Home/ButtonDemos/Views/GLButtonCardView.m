//
//  GLButtonCardView.m
//  Demos
//
//  Created by gaolong on 16/2/8.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLButtonCardView.h"
#import "GLButtonCardDatas.h"
#import "GLButtonCardScrollView.h"

@interface GLButtonCardCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation GLButtonCardCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.layer.cornerRadius = 4.0f;
    self.contentView.layer.borderWidth = 1.0f;
    self.contentView.clipsToBounds = YES;
    self.contentView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.textLabel];
    [self setUpConstraints];
}

- (void)setUpConstraints
{
    [self.imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.imageView autoSetDimension:ALDimensionHeight toSize:60];
    [self.textLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.textLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageView];
    [self.textLabel autoSetDimension:ALDimensionHeight toSize:25.0f];
}

- (void)bindModel:(GLButtonCardModel *)cardModel
{
    if (!cardModel || ![cardModel isKindOfClass:[GLButtonCardModel class]]) {
        return;
    }
    //[self.imageView gl_setImageWithURL:[[NSURL alloc] initWithString:cardModel.imagaUrl]];
    self.imageView.image = [UIImage imageNamed:cardModel.imagaUrl];//先取图片名字
    self.textLabel.text = cardModel.cardName;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView newAutoLayoutView];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _imageView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [UILabel newAutoLayoutView];
        _textLabel.font = APP_FONT_NORMAL;
        _textLabel.numberOfLines = 2.0f;
    }
    return _textLabel;
}

@end

static NSString *const kGLButtonCardCell = @"GLButtonCardCell";
static NSString *const kFooterReuseId = @"footerView";
static NSString *const kHeaderReuseId = @"headerView";
static CGFloat collectionViewWidth = 100.0f;
static CGFloat collectionViewHeight = 85.0f;

@interface GLButtonCardView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray <GLButtonCardModel *> *dataSourceArray;
@property (nonatomic, strong) GLButtonCardData *cardData;

@end

@implementation GLButtonCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    [self addSubview:self.bgImageView];
    [self addSubview:self.collectionView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.pageControl];
    if ([self.pageControl respondsToSelector:@selector(setPageIndicatorTintColor:)]) {
        self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.currentPageIndicatorTintColor = HEXCOLOR(0xff6600);
    }
    self.pageControl.numberOfPages = 5;
    self.page = 0;
    [self setUpConstraints];
}

- (void)setUpConstraints
{
    [self.bgImageView autoPinEdgesToSuperviewEdges];
  
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0f];
    [self.titleLabel autoSetDimensionsToSize:CGSizeMake(200.0f, 30.0f)];
   
    [self.collectionView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.collectionView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.collectionView autoSetDimension:ALDimensionHeight toSize:100.0f];
    
    [self.pageControl autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.pageControl autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.collectionView withOffset: 15.0f];
    [self.pageControl autoSetDimensionsToSize:CGSizeMake(80.0f, 15.0f)];
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [UIImageView newAutoLayoutView];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.image = [UIImage imageNamed:@"button_collection_bgview"];
        _bgImageView.clipsToBounds = YES;
    }
    return _bgImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.font = APP_FONT_NORMAL;
        _titleLabel.textColor = COLOR_TEXT_GRAY;
    }
    return _titleLabel;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumLineSpacing = 0.0f;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[GLButtonCardCell class] forCellWithReuseIdentifier:kGLButtonCardCell];
        [_collectionView registerClass:[GLButtonCardScrollView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterReuseId];
        [_collectionView registerClass:[GLButtonCardScrollView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderReuseId];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [UIPageControl newAutoLayoutView];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.hidden = NO;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = COLOR_TEXT_LIGHT_GRAY;
    }
    return _pageControl;
}

- (void)bindModel:(GLButtonCardData *)cardData
{
    self.cardData = cardData;
    self.dataSourceArray = self.cardData.dataArray;
    self.titleLabel.text = self.cardData.titleName;
    if (self.dataSourceArray.count > 0) {
        self.pageControl.hidden = NO;
    }
    [self.collectionView reloadData];
}

#pragma mark - Collection View Delegate & DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GLButtonCardModel *cardModel = self.dataSourceArray[indexPath.row];
    GLButtonCardCell *cardCell = [collectionView dequeueReusableCellWithReuseIdentifier:kGLButtonCardCell forIndexPath:indexPath];
    [cardCell bindModel:cardModel];

    return cardCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionFooter) {
        GLButtonCardScrollView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kFooterReuseId forIndexPath:indexPath];
        return footerView;
    }else if (kind == UICollectionElementKindSectionHeader) {
        GLButtonCardScrollView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderReuseId forIndexPath:indexPath];
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionViewWidth, collectionViewHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(60.0f, collectionViewHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(15.0f, collectionViewHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GLButtonCardModel *cardModel = self.dataSourceArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(cardViewDidSelectedWithModel:)]) {
        [self.delegate cardViewDidSelectedWithModel:cardModel];
    }
}

#pragma mark scroll view delegate 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = self.page;
}

- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset {
    CGFloat pageSize = collectionViewWidth;
    NSInteger page = roundf(offset.x / pageSize);
    self.page = page;
    CGFloat targetX = pageSize * page;
    return CGPointMake(targetX, offset.y);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:*targetContentOffset];
    targetContentOffset->x = targetOffset.x;
    targetContentOffset->y = targetOffset.y;
    
    if (velocity.x > 0) {
        [self scrollRight];
    } else {
        [self scrollLeft];
    }
}

- (void)scrollLeft {
}

- (void)scrollRight {
}

@end
