//
//  GLScrollViewListVC.m
//  Demos
//
//  Created by gaolong on 16/7/24.
//  Copyright © 2016年 schiller. All rights reserved.
//

#import "GLScrollViewListVC.h"
#import "GLScrollListView.h"

@interface GLScrollViewListVC ()
@property (nonatomic, strong) GLScrollListView *listView;
@end

@implementation GLScrollViewListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"自定义CollectionView";
    
    [self.view addSubview:self.listView];
    [self.listView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.listView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:TOP_BAR_HEIGHT];
    [self.listView configView:nil];
}

- (GLScrollListView *)listView
{
    if (!_listView) {
        _listView = [GLScrollListView newAutoLayoutView];
    }
    return _listView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
