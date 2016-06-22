//
//  ThirdViewController.m
//  Demos
//
//  Created by schiller on 15/7/17.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "ThirdViewController.h"
#import "GLThirdTableViewCell.h"
#import "GLThirdDataSource.h"

@interface ThirdViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GLThirdDataSource *dataSource;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.dataSource = [[GLThirdDataSource alloc] init];
    
    [self setUpViews];
    [self initDatas];
}

- (void)setUpViews
{
    [self.view addSubview:self.tableView];
    [self setUpConstraints];
}

- (void)setUpConstraints
{
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, BOTTOM_BAR_HEIGHT, 0)];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView newAutoLayoutView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GLThirdTableViewCell class] forCellReuseIdentifier:NSStringFromClass([GLThirdTableViewCell class])];
    }
    return _tableView;
}

- (void)initDatas
{
    NSMutableArray *ds = [NSMutableArray array];
    NSArray *titles = @[@"CollectionView", @"Context", @"内存",
                        @"网络", @"动画", @"React-Native",
                        @"音频视频技术", @"即时通讯IM、XMPP", @"架构、私有库"];
    NSArray *subTitles = @[@"研究CollectionView的Layout布局",
                           @"研究Context图文混排",
                           @"研究内存管理模式",
                           @"研究iOS网络相关框架",
                           @"研究动画框架与实现",
                           @"研究react-native前端解决方案",
                           @"研究音频视频技术、图像处理技术等",
                           @"研究即时通讯、XMPP等技术、蓝牙通讯等",
                           @"研究架构、类别、底层控件、运行时等技术"];
    NSArray *urlViewControllers = @[@"GLPhotoCollectionViewController"];
    for (NSInteger i = 0; i< titles.count; i++) {
        GLThirdModel *model = [GLThirdModel new];
        model.title = titles[i];
        model.subTitle = subTitles[i];
        model.imgName = @"a";
        model.urlViewController = (urlViewControllers.count > i) ? urlViewControllers[i]:@"GLBarViewController";
        [ds addObject:model];
    }
    NSArray *array = [NSArray arrayWithArray:ds];
    [self.dataSource setUpCollectionDataSource:array];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GLThirdTableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GLThirdTableViewCell class]) forIndexPath:indexPath];
    GLThirdDataModel *item = self.dataSource.collectionDataSourceArray[indexPath.row];
    [listCell bindModel:item.model];
    return listCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GLThirdDataModel *model = self.dataSource.collectionDataSourceArray[indexPath.row];
    GLThirdModel *data = model.model;
    [UIManager showViewControllerWithName:data.urlViewController];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.collectionDataSourceArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
