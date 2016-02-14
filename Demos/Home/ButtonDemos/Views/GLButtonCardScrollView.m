//
//  GLButtonCardScrollView.m
//  Demos
//
//  Created by gaolong on 16/2/8.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLButtonCardScrollView.h"
#import "GLButtonCardDatas.h"

@implementation GLButtonCardScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    self.backgroundColor = [UIColor redColor];
    [self setUpConstraints];
}

- (void)setUpConstraints
{
    
}

@end

#pragma mark - GLButtonCardPackageScrollView
@interface GLButtonCardPackageScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) GLButtonCardCatogeryView *catogeryView;
@property (nonatomic, strong) UIScrollView *contentScroll;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *viewArray;

@property (nonatomic, strong) GLButtonCardData *cardData;

@end

@implementation GLButtonCardPackageScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    [self addSubview:self.contentScroll];
    [self addSubview:self.pageControl];
    [self setUpViewArray];
    if (self.viewArray) {
        for (GLButtonCardCatogeryView *view in self.viewArray) {
            [self.contentScroll addSubview:view];
        }
    }
    [self setUpConstraints];
}

- (void)setUpConstraints
{
    [self.contentScroll autoPinEdgesToSuperviewEdges];
    [self setUpViewArrayConstraints];
}

- (void)setUpViewArrayConstraints
{
    __block GLButtonCardCatogeryView *leftView = [self.viewArray firstObject];
    [self.viewArray enumerateObjectsUsingBlock:^(GLButtonCardCatogeryView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        [view autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [view autoSetDimensionsToSize:CGSizeMake(100.0f, 90.0f)];
        if (idx == 0) {
            [view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0f];
        }else {
            [view autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:leftView withOffset:10.0f];
            leftView = view;
        }
    }];
}

- (void)setUpViewArray
{
    if (!_viewArray) {
        _viewArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 5; i++) {
            GLButtonCardCatogeryView *catogeryView = [GLButtonCardCatogeryView newAutoLayoutView];
            [_viewArray addObject:catogeryView];
        }
    }
}

- (void)bindModel:(id)model
{
    self.cardData = (GLButtonCardData *)model;
    [self.viewArray enumerateObjectsUsingBlock:^(GLButtonCardCatogeryView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        [view bindData:self.cardData.dataArray[idx]];
    }];
}

- (GLButtonCardCatogeryView *)catogeryView
{
    if (!_catogeryView) {
        _catogeryView = [GLButtonCardCatogeryView newAutoLayoutView];
    }
    return _catogeryView;
}

- (UIScrollView *)contentScroll
{
    if (!_contentScroll) {
        _contentScroll = [UIScrollView newAutoLayoutView];
        _contentScroll.backgroundColor = [UIColor redColor];
        _contentScroll.pagingEnabled = YES;
        _contentScroll.showsHorizontalScrollIndicator = NO;
        _contentScroll.showsVerticalScrollIndicator = NO;
        _contentScroll.bounces = NO;
        _contentScroll.delegate = self;
    }
    return _contentScroll;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [UIPageControl newAutoLayoutView];
        _pageControl.currentPage = 0;
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.pageIndicatorTintColor = HEXCOLOR(0xeeeeee);
        _pageControl.currentPageIndicatorTintColor = COLOR_ORANGE;
    }
    return _pageControl;
}

@end

#pragma mark - GLButtonCardCatogeryView
@interface GLButtonCardCatogeryView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation GLButtonCardCatogeryView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction)];
    [self addGestureRecognizer:tapGesture];
    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 1.0f;
    self.clipsToBounds = YES;
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self setUpConstraints];
}

- (void)handleTapAction
{
    if ([self.delegate respondsToSelector:@selector(tapAction)]) {
        [self.delegate tapAction];
    }
}

- (void)setUpConstraints
{
    [self.imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.imageView autoSetDimension:ALDimensionHeight toSize:60.0f];
    [self.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageView];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:25.0f];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView newAutoLayoutView];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel.font = APP_FONT_LARGE;
        _titleLabel.textColor = COLOR_TEXT_GRAY;
        _titleLabel.numberOfLines = 2.0f;
    }
    return _titleLabel;
}

- (void)bindData:(id)data
{
    if (!data || ![data isKindOfClass:[GLButtonCardModel class]]) {
        return;
    }
    GLButtonCardModel *cardModel = (GLButtonCardModel *)data;
    self.titleLabel.text = cardModel.cardName;
    self.imageView.image = [UIImage imageNamed:cardModel.imagaUrl];
}

@end