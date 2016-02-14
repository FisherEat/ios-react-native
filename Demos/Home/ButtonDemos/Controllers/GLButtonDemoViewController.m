//
//  GLButtonDemoViewController.m
//  Demos
//
//  Created by gaolong on 16/2/7.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLButtonDemoViewController.h"
#import "GLButtonCardView.h"
#import "GLButtonCardDatas.h"
#import "GLButtonCardScrollView.h"

@interface GLButtonDemoViewController ()<GLTopBarViewDelegate, GLButtonCardViewDelegate>

@property (nonatomic, strong) GLButtonCardView *cardView;
@property (nonatomic, strong) GLButtonCardData *cardData;
@property (nonatomic, strong) GLButtonCardPackageScrollView *scrollView;

@end

@implementation GLButtonDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDatas];
    [self setUpTopBar];
    [self setUpCardView];
    [self setUpScrollView];
}

- (void)setUpTopBar
{
    self.topBarView.topBarStytle = GLTopBarStyleTitleLeftButtonRightButton;
    self.topBarView.titleText = @"测试按钮页";
    self.topBarView.delegate = self;
    self.topBarView.rightButtonTitle = @"更多";
}

- (void)setUpCardView
{
    self.cardView = [GLButtonCardView newAutoLayoutView];
    [self.cardView bindModel:self.cardData];
    self.cardView.delegate = self;
    [self.view addSubview:self.cardView];

    [self setUpConstraints];
}

- (void)setUpScrollView
{
    self.scrollView = [[GLButtonCardPackageScrollView alloc] init];
    [self.scrollView bindModel:self.cardData];
    [self.view addSubview:self.scrollView];
    [self setUpScrollViewConstraints];
}

- (void)setUpConstraints
{
    [self.cardView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64.5, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.cardView autoSetDimension:ALDimensionHeight toSize:155.0f];
}

- (void)setUpScrollViewConstraints
{
    [self.scrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.cardView];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.scrollView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.scrollView autoSetDimension:ALDimensionHeight toSize:120.0f];
}

- (void)initDatas
{
    self.cardData = [[GLButtonCardData alloc] init];
    NSMutableArray *dataArray = [NSMutableArray array];
  
    NSArray *cardNames = @[@"美物卡", @"音乐卡", @"良言卡", @"应用卡", @"视频卡"];
    NSArray *imageUrls = @[@"hu.png", @"juhua.png", @"mudan.png", @"shui.png", @"youcaihua.png"];
    
    for (NSInteger i = 0; i < cardNames.count; i ++ ) {
        GLButtonCardModel *model = [[GLButtonCardModel alloc] init];
        model.cardName = cardNames[i];
        model.imagaUrl = imageUrls[i];
        [dataArray addObject:model];
    }
    self.cardData.dataArray = dataArray;
    self.cardData.titleName = @"集齐五张传情卡，有特别惊喜哦";
}

- (void)cardViewDidSelectedWithModel:(GLButtonCardModel *)cardModel
{
    [UIManager showViewControllerWithName:@"GLButtonDemoViewController101"];
}

- (void)topBarLeftButtonPressed:(UIButton *)button
{
    [UIManager backHome];
}

- (void)topBarRightButtonPressed:(UIButton *)button
{
    [UIManager showViewControllerWithName:@"GLButtonDemoViewController101"];
}

@end
