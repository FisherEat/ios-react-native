//
//  GLPresentViewController.m
//  Demos
//
//  Created by gaolong on 15/8/27.
//  Copyright (c) 2015年 schiller. All rights reserved.
//

#import "GLPresentViewController.h"
#import "TNTableViewCell.h"

@interface GLPresentInfoCell()

@end

@implementation GLPresentInfoCell

- (void)bindModel:(NSDictionary *)cellData
{
    self.nameLabel.text = cellData[@"personName"];
    self.ageLabel.text  = cellData[@"personAge"];
}

@end

@interface GLPresentViewController ()<GLTopBarViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GLPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.topBarView.topBarStytle = GLTopBarStyleTitleLeftButtonRightButton;
    self.topBarView.titleText = @"哈哈";
    self.topBarView.leftButtonTitle = @"返回";
    self.topBarView.rightButtonTitle = @"更多";
    self.topBarView.delegate = self;
   // [self setLeftButtonToBackButton];
    [self.view addSubview:self.topBarView];
    
    [self showTableView];
}

- (void)showTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.y = self.topBarView.bottom;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TNTableViewCell *cell = nil;
    cell = (GLPresentInfoCell *)[GLPresentInfoCell cellForTableView:tableView];
    [(GLPresentInfoCell *)cell bindModel:@{@"personName":@"席勒", @"personAge":@(18)}];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark 隐藏导航栏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark GLTopBarViewDelegate
- (void)topBarLeftButtonPressed:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
