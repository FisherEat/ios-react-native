//
//  GLTrainScrollBarView.m
//  Demos
//
//  Created by schiller on 15/9/15.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "GLTrainScrollBarView.h"
#import "config.h"

static const CGFloat indicatorMargin = 10.0f;

@interface GLTrainScrollBarView (){
    CGFloat buttonWidth;
}


@property (nonatomic, strong) NSArray *trainInfoArray;
@property (nonatomic, strong) UIScrollView *scrollBarView;
@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) NSMutableArray *buttonArray;//单程、返程
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation GLTrainScrollBarView

- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        _titleColor = COLOR_TEXT_GRAY;
        _selectedTitleColor = GL_COLOR_GREEN;
        _titleFont = APP_FONT_NORMAL;
        _indicatorColor = GL_COLOR_GREEN;
        _selectedIndex = -1;
        buttonWidth = SCREEN_WIDTH / 2;
        
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor whiteColor];
    _scrollBarView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollBarView.backgroundColor = [UIColor whiteColor];
    _scrollBarView.showsHorizontalScrollIndicator = NO;
    _scrollBarView.scrollsToTop = NO;
    [self addSubview:_scrollBarView];
    
    _indicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth - 2 * indicatorMargin, 2.0f)];
    _indicator.backgroundColor = _indicatorColor;
    [_scrollBarView addSubview:_indicator];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5f, self.width, 0.5f)];
    bottomLine.backgroundColor = HEXCOLOR(0xd4d4d4);
    [self addSubview:bottomLine];
    
    [self setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self setNeedsDisplay];
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    _selectedTitleColor = selectedTitleColor;
    [self setNeedsDisplay];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [self setNeedsDisplay];
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    _indicator.backgroundColor = _indicatorColor;
}

#pragma mark - 更新界面

- (void)updateWithTrainTicketInfoArray:(NSArray *)trainInfoArray
{
    _trainInfoArray = trainInfoArray;
    if (_buttonArray.count > 0) {
        [_buttonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
            [button removeFromSuperview];
        }];
        [_buttonArray removeAllObjects];
    }
    else {
        _buttonArray = [NSMutableArray array];
    }
    
    __block NSInteger selectedIndex = 0;
    
    [_trainInfoArray enumerateObjectsUsingBlock:^(NSDictionary *info, NSUInteger idx, BOOL *stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(idx * buttonWidth, 0, buttonWidth, self.height - 2.0f)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTitleColor:_titleColor forState:UIControlStateNormal];
        [button setTitleColor:_selectedTitleColor forState:UIControlStateSelected];
        [button.titleLabel setFont:_titleFont];
        [button setTitle:info[@"name"] forState:UIControlStateNormal];
        button.tag = idx;
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        
        [button addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([info[@"selected"] boolValue] == YES) {
            selectedIndex = idx;
        }
        [_scrollBarView addSubview:button];
        [_buttonArray addObject:button];
    }];
    
    CGFloat contentWidth = _buttonArray.count * buttonWidth;
    if (contentWidth <_scrollBarView.width) {
        contentWidth = _scrollBarView.width;
    }
    _scrollBarView.contentSize = CGSizeMake(contentWidth, 0);
    
    [self updateSelectedIndex:selectedIndex scrollToLeft:YES];

}

- (void)updateSelectedIndex:(NSInteger)selectedIndex scrollToLeft:(BOOL)scrollToLeft
{
    if (_selectedIndex != selectedIndex) {
        //计算移动距离
        NSInteger interval = (selectedIndex - _selectedIndex);
        _selectedIndex = selectedIndex;
        if (_buttonArray.count > 0) {
            [_buttonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
                button.selected = (idx == _selectedIndex) ? YES : NO;
            }];
        }
        
        interval = (interval < 0)? -interval : interval;
        CGFloat intervalTime = interval * 0.1f;
        [UIView animateWithDuration:intervalTime animations:^{
            _indicator.x = _selectedIndex * buttonWidth + indicatorMargin;
        }];
        if (scrollToLeft) {
            CGFloat contentOffsetWidth = _selectedIndex * buttonWidth;
            if (contentOffsetWidth > _scrollBarView.contentSize.width - self.width) {
                contentOffsetWidth = _scrollBarView.contentSize.width - self.width;
            }
            _scrollBarView.contentOffset = CGPointMake(contentOffsetWidth, 0);
        }
    }
}

- (void)titleButtonClicked:(UIButton *)sender
{
    if (sender.tag != _selectedIndex) {
        [self updateSelectedIndex:sender.tag scrollToLeft:NO];
        if (self.switchedBlock) {
            self.switchedBlock(self.selectedIndex);
        }
    }
}
@end
