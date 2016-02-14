//
//  AddTBCellViewController.m
//  Demos
//
//  Created by gaolong on 15/8/30.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "AddTBCellViewController.h"
#import "MainCell.h"
#import "GLHeaderView.h"
#import "GLNavigator.h"

@interface AddTBCellViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GLHeaderView *headerView;
@property (nonatomic, assign) NSInteger cellNumber;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) NSInteger selectSection;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation AddTBCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    self.tableView.y = self.topBarView.bottom;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    [self setUpRightButton];
    self.isOpen = NO;
}

- (void)setUpRightButton
{
    [self.view addSubview:self.rightButton];
    [self.rightButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100.0f];
    [self.rightButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [self.rightButton autoSetDimensionsToSize:CGSizeMake(80, 35)];
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton newAutoLayoutView];
        [_rightButton setTitle:@"返回首页" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.titleLabel.font = APP_FONT_NORMAL;
    }
    return _rightButton;
}

- (void)backHome
{
    [[GLNavigator navigator] to:@"demoapp://demo/third"];
}

#pragma mark - TableView Delegate 、TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectSection == section) {
        return self.cellNumber;
    }else
        
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerView = [[GLHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 50)];
    self.headerView.backgroundColor = [UIColor colorwithHexString:@"#e4f4e8"];
    if (section == 0) {
        [self.headerView.headerButton addTarget:self action:@selector(toggleCell) forControlEvents:UIControlEventTouchUpInside];
    }
//    [self.headerView.headerButton addTarget:self action:@selector(toggleCell) forControlEvents:UIControlEventTouchUpInside];
    return self.headerView;
}

- (void)toggleCell
{
    if (!self.isOpen) {
        self.isOpen = YES;
         self.cellNumber = 2;
    }else {
        self.isOpen = NO;
        self.cellNumber = 0;
    }
    
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = NSStringFromClass([self class]);
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
