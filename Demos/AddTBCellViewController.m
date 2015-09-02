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

@interface AddTBCellViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GLHeaderView *headerView;
@property (nonatomic, assign) NSInteger cellNumber;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) NSInteger selectSection;

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
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleCell)];
//    [self.headerView addGestureRecognizer:tap];
    
    self.isOpen = NO;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
